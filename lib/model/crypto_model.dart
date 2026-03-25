class CryptoModel {
  String id;
  String symbol;
  String name;
  String image;
  double current_price;
  double price_change_percentage_24h;
  final List<dynamic> sparkLineIn7d;

  CryptoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.current_price,
    required this.price_change_percentage_24h,
    required this.sparkLineIn7d,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json["id"],
      symbol: json["symbol"],
      name: json["name"],
      image: json["image"],
      current_price: (json['current_price'] ?? 0).toDouble(),
      price_change_percentage_24h: (json['price_change_percentage_24h'] ?? 0)
          .toDouble(),

      sparkLineIn7d: json['sparkLineIn7d']?['price'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "symbol": symbol,
      "name": name,
      "image": image,
      "current_price": current_price,
      "price_change_percentage_24h": price_change_percentage_24h,
    };
  }
}
