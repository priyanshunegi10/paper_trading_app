abstract final class FirestoreConstants {
  // Collections & Subcollections
  static const String usersCollection = 'users';
  static const String watchlistCollection = 'watchlist';
  static const String portfolioCollection = 'portfolio';
  static const String transactionsCollection = 'transactions';

  // User Document Fields
  static const String uid = 'uid';
  static const String email = 'email';
  static const String name = 'name';
  static const String balance = 'balance';
  static const String createdAt = 'createdAt';

  // Shared & Watchlist Fields
  static const String coinId = 'coinId';
  static const String addedAt = 'addedAt';

  // Portfolio Fields
  static const String symbol = 'symbol';
  static const String quantity = 'quantity';
  static const String buyPrice = 'buyPrice';

  // Transaction Fields
  static const String type = 'type';
  static const String price = 'price';
  static const String totalAmount = 'totalAmount';
  static const String timestamp = 'timestamp';

  // Fixed Database Values & Defaults
  static const String transactionTypeBuy = 'BUY';
  static const String transactionTypeSell = 'SELL';
  static const double initialBalance = 100000.0;
}
