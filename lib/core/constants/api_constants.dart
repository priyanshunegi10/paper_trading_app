abstract final class ApiConstants {
  // URLS

  static const String baseUrl = "https://api.coingecko.com/api/v3";
  static const String coinsMarketsEndpoint = "/coins/markets";

  // Query Keys
  static const String vsCurrencyKey = "vs_currency";
  static const String sparklineKey = "sparkline";
  static const String orderKey = "order";
  static const String perPageKey = "per_page";
  static const String pageKey = "page";

  // Default Values

  static const String defaultCurrency = "usd";
  static const String defaultOrder = "market_cap_desc";
  static const int defaultPerPage = 50;
  static const int defaultPage = 1;
  static const bool defaultSparkline = true;

  // Timeouts

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Retry & Polling

  static const int maxRetries = 3;
  static const Duration initialRetryDelay = Duration(seconds: 2);
  static const Duration marketRefreshInterval = Duration(seconds: 60);

  // Headers

  static const String contentTypeJson = "application/json";
}
