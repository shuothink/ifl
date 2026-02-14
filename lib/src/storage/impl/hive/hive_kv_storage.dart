import '../../kv_storage.dart';
import 'hive_box_contract.dart';

/// [KvStorage] implementation backed by a Hive-style box.
///
/// Integrators should adapt real Hive box objects to [HiveBoxContract].
class HiveKvStorage implements KvStorage {
  HiveKvStorage(this._box);

  final HiveBoxContract _box;

  @override
  String get name => _box.name;

  @override
  Future<void> clear() {
    return _box.clear();
  }

  @override
  Future<void> close() {
    return _box.close();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _box.containsKey(key);
  }

  @override
  Future<void> delete(String key) {
    return _box.delete(key);
  }

  @override
  Future<List<String>> keys() async {
    final result = _box.keys.toList()..sort();
    return result;
  }

  @override
  Future<String?> read(String key) async {
    return _box.get(key);
  }

  @override
  Future<void> write(String key, String value) {
    return _box.put(key, value);
  }
}
