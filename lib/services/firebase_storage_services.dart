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
    DocumentReference userRef = _db.collection("users").doc(user.uid);

    DocumentReference portfolioRef = userRef
        .collection("portfolio")
        .doc(coinId);
    DocumentReference transactionRef = userRef.collection('transactions').doc();

    return _db.runTransaction((transaction) async {
      // all the reads
      DocumentSnapshot userDoc = await transaction.get(userRef);
      DocumentSnapshot portfolioDoc = await transaction.get(portfolioRef);

      // calculations
      if (!userDoc.exists) throw Exception("User data not found!");

      double currentBalance = (userDoc.get('balance') as num).toDouble();
      double totalCost = coinPrice * quantity;

      if (currentBalance < totalCost) {
        throw Exception(
          "Bhai balance kam hai! Total cost: \$${totalCost.toStringAsFixed(2)}",
        );
      }

      double newBalance = currentBalance - totalCost;

      // avg price

      double finalQuantity = quantity;
      double finalBuyPrice = coinPrice;

      if (portfolioDoc.exists) {
        double existingQty = (portfolioDoc.get('quantity') as num).toDouble();
        double existingBuyPrice = (portfolioDoc.get('buyPrice') as num)
            .toDouble();
        double totalExistingValue = existingQty * existingBuyPrice;
        double totalNewValue = quantity * coinPrice;

        finalQuantity = existingQty + quantity;
        finalBuyPrice = (totalExistingValue + totalNewValue) / finalQuantity;
      }

      // all the writes
      transaction.update(userRef, {'balance': newBalance});
      if (portfolioDoc.exists) {
        transaction.update(portfolioRef, {
          'quantity': finalQuantity,
          'buyPrice': finalBuyPrice,
        });
      } else {
        transaction.set(portfolioRef, {
          'coinId': coinId,
          'symbol': symbol,
          'quantity': finalQuantity,
          'buyPrice': finalBuyPrice,
        });
      }

      transaction.set(transactionRef, {
        'coinId': coinId,
        'symbol': symbol,
        'type': 'BUY',
        'price': coinPrice,
        'quantity': quantity,
        'totalAmount': totalCost,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }

  // sell coin
  Future<void> sellCoin(
    String coinId,
    double currentMarketPrice,
    double quantityToSell,
    String symbol,
  ) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("Please login first");

    DocumentReference userRef = _db.collection("users").doc(user.uid);
    DocumentReference portfolioRef = userRef
        .collection("portfolio")
        .doc(coinId);
    DocumentReference transactionRef = userRef.collection('transactions').doc();

    return _db.runTransaction((transcation) async {
      // Reads

      DocumentSnapshot userDoc = await transcation.get(userRef);
      DocumentSnapshot portfolioDoc = await transcation.get(portfolioRef);

      // calculations

      if (!userDoc.exists) throw Exception("User data not found!");
      if (!portfolioDoc.exists) {
        throw Exception("Bhai, tere paas ye coin hai hi nahi bechne ke liye!");
      }

      double currentBalanace = (userDoc.get('balance') as num).toDouble();
      double existingQuantity = (portfolioDoc.get('quantity') as num)
          .toDouble();

      if (quantityToSell > existingQuantity) {
        throw Exception(
          "Tere paas sirf $existingQuantity sikke hain, tu $quantityToSell nahi bech sakta!",
        );
      }

      // Paison ko balance mein add karna

      double totalEarned = quantityToSell * currentMarketPrice;
      double newBalance = currentBalanace + totalEarned;

      double remainingQuantity = existingQuantity - quantityToSell;

      // writes

      transcation.update(userRef, {'balance': newBalance});

      if (remainingQuantity > 0) {
        transcation.update(portfolioRef, {'quantity': remainingQuantity});
      } else {
        transcation.delete(portfolioRef);
      }

      transcation.set(transactionRef, {
        'coinId': coinId,
        'symbol': symbol,
        'type': 'SELL',
        'price': currentMarketPrice,
        'quantity': quantityToSell,
        'totalAmount': totalEarned,
        'timeStamp': FieldValue.serverTimestamp(),
      });
    });
  }

  // portfolio stream (constant portfolio ko dekhta rahega ki usme kya kya changes hei )

  Stream<List<Map<String, dynamic>>> getPortfolioStream() {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("Please login first");

    // location kha mere coins honge
    return _db
        .collection("users")
        .doc(user.uid)
        .collection("portfolio")
        .snapshots() // firebase direct list nhi bejta hei isliye .map lga kr loop chalaya or list saaf kr di
        .map((snapshort) {
          return snapshort.docs.map((doc) => doc.data()).toList();
        });
  }

  // transcation kei liye live pipeling

  Stream<List<Map<String, dynamic>>> getTranscationHistory() {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("Please login first");

    return _db
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshort) {
          return snapshort.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
  }
}
