abstract class CacheConstants {
  // Hive Box Names
  static const String marketCacheBox = 'market_cache_box';
  static const String settingsBox = 'settings_box';

  // Storage Keys
  static const String cachedCoinsKey = 'cached_coins';
  static const String marketLastUpdatedKey = 'market_last_updated';
  static const String themeModeKey = 'theme_mode';

  // Cache Expiry (TTL)
  static const Duration marketCacheExpiry = Duration(minutes: 5);
}
