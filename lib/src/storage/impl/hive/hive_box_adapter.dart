import 'package:hive/hive.dart';

import 'hive_box_contract.dart';

/// Adapts a real Hive [Box] to [HiveBoxContract].
class HiveBoxAdapter implements HiveBoxContract {
  HiveBoxAdapter(this._box);

  final Box<String> _box;

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
  bool containsKey(String key) {
    return _box.containsKey(key);
  }

  @override
  Future<void> delete(String key) {
    return _box.delete(key);
  }

  @override
  String? get(String key) {
    return _box.get(key);
  }

  @override
  Iterable<String> get keys {
    return _box.keys.whereType<String>();
  }

  @override
  Future<void> put(String key, String value) {
    return _box.put(key, value);
  }
}
