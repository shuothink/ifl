import '../../kv_storage.dart';
import 'secure_storage_client.dart';

/// [KvStorage] implementation backed by a secure storage client.
///
/// Keys are namespaced by [name] to support multiple logical storages.
class FlutterSecureStorageKvStorage implements KvStorage {
  FlutterSecureStorageKvStorage({
    required this.name,
    required SecureStorageClient client,
  }) : _client = client;

  final SecureStorageClient _client;

  @override
  final String name;

  String _fullKey(String key) => '$name::$key';

  @override
  Future<void> clear() async {
    final all = await _client.readAll();
    final targets = all.keys.where((k) => k.startsWith('$name::')).toList();
    for (final key in targets) {
      await _client.delete(key);
    }
  }

  @override
  Future<void> close() async {}

  @override
  Future<bool> containsKey(String key) async {
    final value = await _client.read(_fullKey(key));
    return value != null;
  }

  @override
  Future<void> delete(String key) {
    return _client.delete(_fullKey(key));
  }

  @override
  Future<List<String>> keys() async {
    final all = await _client.readAll();
    final prefix = '$name::';
    final result = all.keys
        .where((key) => key.startsWith(prefix))
        .map((key) => key.substring(prefix.length))
        .toList()
      ..sort();
    return result;
  }

  @override
  Future<String?> read(String key) {
    return _client.read(_fullKey(key));
  }

  @override
  Future<void> write(String key, String value) {
    return _client.write(_fullKey(key), value);
  }
}
