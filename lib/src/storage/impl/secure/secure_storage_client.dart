/// Minimal client contract for secure key-value backends.
///
/// Real adapters can wrap `flutter_secure_storage` without exposing it as a
/// required type in package API boundaries.
abstract interface class SecureStorageClient {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);

  Future<Map<String, String>> readAll();

  Future<void> deleteAll();
}
