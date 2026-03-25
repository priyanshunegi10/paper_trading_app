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

  Future<void> buyCoin(
    String coinId,
    String symbol,
    double coinPrice,
    double quantity,
  ) async {
    User? user = _auth.currentUser;

    if (user == null) throw Exception("please login fisrt");

    DocumentReference userRef = _db.collection("users").doc(user.uid);
    DocumentReference portfolioRef = _db.collection("portfolio").doc(coinId);

    //FIREBASE TRANSACTION
    await _db.runTransaction((transaction) async {
      DocumentSnapshot userDoc = await transaction.get(userRef);

      if (!userDoc.exists) throw Exception("User not found");

      double currentBalance = (userDoc.get('balance') as num).toDouble();
      double totalCost = coinPrice * quantity;


      // check is you have enough money
      if (currentBalance < totalCost) {
        throw Exception("You dont have enough money");
      }


      // PAISE KAATO
      double newBalance = currentBalance - totalCost;
      transaction.update(userRef, {'balance': newBalance});


      // PORTFOLIO MEIN COIN DAALO
      DocumentSnapshot portfolioDoc = await transaction.get(portfolioRef);

      if (portfolioDoc.exists) {

        // Agar coin pehle se hai, toh quantity mein add kar
        double existingQty = (portfolioDoc.get('quantity') as num).toDouble();
        transaction.update(portfolioRef, {'quantity': existingQty + quantity});
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
}
