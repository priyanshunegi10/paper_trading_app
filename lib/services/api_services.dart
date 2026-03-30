import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paper_trading_app/model/crypto_model.dart';

class ApiServices {
  static const String baseUrl = "https://api.coingecko.com/api/v3";

  Future<List<CryptoModel>> getData() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/coins/markets?vs_currency=usd&sparkline=true"),
      );

      if (response.statusCode == 200) {
        List<dynamic> decodedData = jsonDecode(response.body);

        return decodedData.map((json) => CryptoModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'API ne reject kar diya. Status Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Data fetch karne mein error aayi: $e');
    }
  }
}
