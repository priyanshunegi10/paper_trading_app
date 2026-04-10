import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseStorageServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // get user data
  Stream<DocumentSnapshot> getUserProfile() {
    User? user = _auth.currentUser;

    if (user == null) throw Exception("User not logged in");

    return _db.collection('users').doc(user.uid).snapshots();
  }

  // stock add
  Future<void> addCoinToWatchlist(String coinId) async {
    User? user = _auth.currentUser;

    if (user == null) throw Exception("Please go and login first");

    await _db
        .collection("users")
        .doc(user.uid)
        .collection("watchlist")
        .doc(coinId)
        .set({'coinId': coinId, 'addedAt': FieldValue.serverTimestamp()});
  }

  // remove stock
  Future<void> removeFromWatchlist(String coinId) async {
    User? user = _auth.currentUser;

    if (user == null) throw Exception("Please go and login first");

    await _db
        .collection("users")
        .doc(user.uid)
        .collection("watchlist")
        .doc(coinId)
        .delete();
  }

  // get watchlist

  Stream<List<String>> getWatchlist() {
    User? user = _auth.currentUser;

    if (user == null) return Stream.value([]);

    return _db
        .collection("users")
        .doc(user.uid)
        .collection("watchlist")
        .snapshots()
        .map((snapshort) => snapshort.docs.map((doc) => doc.id).toList());
  }

  // coin buy karne ka funtion

  Future<void> buyCoin(
    String coinId,
    String symbol,
    double coinPrice,
    double quantity,
  ) async {
    // check user
    User? user = _auth.currentUser;
    if (user == null) throw Exception("Login fisrt");

    // DocumentReference address
    DocumentReference userRef = _db.collection("users.").doc(user.uid);

    // Portfolio user ke andar hona chahiye (Sub-collection)
    DocumentReference portfolioRef = userRef
        .collection("portfolio")
        .doc(coinId);

    await _db.runTransaction((transaction) async {
      DocumentSnapshot userDoc = await transaction.get(userRef);

      if (!userDoc.exists) throw Exception("User not found");

      double currentBalance = (userDoc.get('balance') as num).toDouble();
      double totalCost = coinPrice * quantity;

      if (currentBalance < totalCost) {
        throw Exception("You don't have enough money");
      }
      // 1. PAISE KAATO
      double newBalance = currentBalance - totalCost;
      transaction.update(userRef, {'balance': newBalance});

      // 2. PORTFOLIO MEIN COIN DAALO
      DocumentSnapshot portfolioDoc = await transaction.get(portfolioRef);

      if (portfolioDoc.exists) {
        // Average Price Calculation (The real math)
        double existingQty = (portfolioDoc.get('quantity') as num).toDouble();
        double existingBuyPrice = (portfolioDoc.get('buyPrice') as num)
            .toDouble();

        // Purani value + Nayi value ko mila kar naya average nikalna
        double totalExistingValue = existingQty * existingBuyPrice;
        double totalNewValue = quantity * coinPrice;

        double newTotalQty = existingQty + quantity;
        double newAveragePrice =
            (totalExistingValue + totalNewValue) / newTotalQty;

        transaction.update(portfolioRef, {
          'quantity': newTotalQty,
          'buyPrice': newAveragePrice, // Naya average price update hoga
        });
      } else {
        // Naya coin hai, toh naya record
        transaction.set(portfolioRef, {
          'coinId': coinId,
          'symbol': symbol,
          'quantity': quantity,
          'buyPrice': coinPrice,
          'purchasedAt': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  // sell coin
  Future<void> sellCoin(
    String coinId,
    double currentMarketPrice,
    double quantityToSell,
  ) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("Please login first");

    DocumentReference userRef = _db.collection("users").doc(user.uid);
    DocumentReference portfolioRef = userRef
        .collection("portfolio")
        .doc(coinId);

    // FIREBASE TRANSACTION
    await _db.runTransaction((transaction) async {
      // 1. DATA READ KARO
      DocumentSnapshot userDoc = await transaction.get(userRef);
      DocumentSnapshot portfolioDoc = await transaction.get(portfolioRef);

      if (!userDoc.exists) throw Exception("User not found");
      if (!portfolioDoc.exists) throw Exception("You don't own this coin");

      // 2. CHECK KARO KI KYA UTNE COINS HAIN BHI YA NAHI?
      double existingQty = (portfolioDoc.get('quantity') as num).toDouble();

      if (existingQty < quantityToSell) {
        throw Exception(
          "You only have $existingQty coins. You can't sell $quantityToSell.",
        );
      }

      // 3. PAISE WALLET MEIN DAALO (Add to Balance)
      double currentBalance = (userDoc.get('balance') as num).toDouble();
      double totalRevenue = currentMarketPrice * quantityToSell;

      double newBalance = currentBalance + totalRevenue;
      transaction.update(userRef, {'balance': newBalance});

      // 4. PORTFOLIO SE COIN KAATO
      double remainingQty = existingQty - quantityToSell;

      if (remainingQty == 0) {
        // Agar saare coins bech diye, toh database se record hi uda do (Clean up)
        transaction.delete(portfolioRef);
      } else {
        // Agar thode coins bache hain, toh sirf quantity update karo
        // (Note: Buy Price update nahi hota sell karte waqt)
        transaction.update(portfolioRef, {'quantity': remainingQty});
      }
    });
  }
}
