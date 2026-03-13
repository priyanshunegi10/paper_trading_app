class CryptoModel {
  String id;
  String symbol;
  String name;
  String image;
  double current_pricel;
  double price_change_percentage_24h;

  CryptoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.current_pricel,
    required this.price_change_percentage_24h,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> map) {
    return CryptoModel(
      id: map["id"],
      symbol: map["symbol"],
      name: map["name"],
      image: map["image"],
      current_pricel: map["current_pricel"],
      price_change_percentage_24h: map["price_change_percentage_24h"],
    );
  }


  
}
