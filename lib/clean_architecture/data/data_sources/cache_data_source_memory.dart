import 'package:clock/clock.dart';

class CacheDataSourceMemory<T> {
  static const String noIdCacheField = 'all';
  static const int cacheDuration = 86400; // 1 day
  final Map<String, CacheItem<T>> _cache = <String, CacheItem<T>>{};
  final Clock clock;

  Map<String, CacheItem<T>> get cache => _cache;

  bool get isNotEmpty => _cache.isNotEmpty;

  CacheDataSourceMemory({this.clock = const Clock()});

  T? getItem({String id = noIdCacheField}) {
    final cachedItem = _cache[id];
    if (cachedItem != null) {
      if (cachedItem.isExpired(clock)) {
        removeItem(id: id);
      } else {
        return cachedItem.item;
      }
    }
    return null;
  }

  void setItem(T cache, {String id = noIdCacheField}) {
    final expiredData = _createExpiredDate();
    _cache[id] = CacheItem<T>(cache, expiredData);
  }

  void clearCache() {
    _cache.clear();
  }

  void removeItem({required String id}) {
    _cache.remove(id);
  }

  DateTime _createExpiredDate() {
    return clock.now().add(const Duration(seconds: cacheDuration));
  }
}

class CacheItem<T> {
  final T item;
  final DateTime timestamp;

  CacheItem(this.item, this.timestamp);

  bool isExpired(Clock clock) => timestamp.isBefore(clock.now());
}
