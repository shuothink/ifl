library ifl_hive;

import 'package:hive/hive.dart';

import 'ifl.dart';
import 'src/storage/impl/hive/hive_box_adapter.dart';
import 'src/storage/impl/hive/hive_kv_storage.dart';

/// Creates a [KvStorage] backed by a Hive [Box].
///
/// Consumers should import `package:ifl/ifl_hive.dart` instead of importing
/// `src/` internals directly.
KvStorage createHiveKvStorage(Box<String> box) {
  return HiveKvStorage(HiveBoxAdapter(box));
}
