import 'storage.dart';

/// Contract for key-value storage based on string key/value pairs.
///
/// Different engines (Hive, flutter_secure_storage, etc.) can implement this
/// contract without affecting upper business layers.
abstract interface class KvStorage implements Storage {
  /// Returns `true` when [key] exists.
  Future<bool> containsKey(String key);

  /// Reads a value by [key]. Returns `null` when not found.
  Future<String?> read(String key);

  /// Writes [value] for [key].
  Future<void> write(String key, String value);

  /// Deletes [key] when present.
  Future<void> delete(String key);

  /// Clears all key-value pairs in this storage namespace.
  Future<void> clear();

  /// Returns all existing keys.
  Future<List<String>> keys();
}
