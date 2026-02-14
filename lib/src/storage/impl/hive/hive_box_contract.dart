/// Minimal box contract used by [HiveKvStorage].
///
/// This boundary keeps package:ifl independent from a concrete Hive version.
abstract interface class HiveBoxContract {
  String get name;

  bool containsKey(String key);

  String? get(String key);

  Iterable<String> get keys;

  Future<void> put(String key, String value);

  Future<void> delete(String key);

  Future<void> clear();

  Future<void> close();
}
