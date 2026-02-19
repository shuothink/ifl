library ifl_hive;

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'ifl.dart';
import 'src/storage/impl/hive/hive_box_adapter.dart';
import 'src/storage/impl/hive/hive_kv_storage.dart';

bool _isHiveInitialized = false;
String? _initializedSubDir;
Future<void>? _hiveInitFuture;

Future<void> _ensureDefaultHiveInitialized(String subDir) async {
  if (_isHiveInitialized) {
    if (_initializedSubDir != subDir) {
      debugPrint(
        'initHiveKvStorage: Hive already initialized with subDir '
        '"$_initializedSubDir"; ignoring new subDir "$subDir".',
      );
    }
    return;
  }

  final ongoing = _hiveInitFuture;
  if (ongoing != null) {
    await ongoing;
    if (_initializedSubDir != subDir) {
      debugPrint(
        'initHiveKvStorage: Hive already initialized with subDir '
        '"$_initializedSubDir"; ignoring new subDir "$subDir".',
      );
    }
    return;
  }

  _hiveInitFuture = () async {
    await Hive.initFlutter(subDir);
    _isHiveInitialized = true;
    _initializedSubDir = subDir;
  }();
  await _hiveInitFuture;
}

/// Creates a [KvStorage] backed by a Hive [Box], opening the box by name.
///
/// This factory avoids exposing Hive [Box] to consumer code and initializes
/// Hive automatically on first use.
Future<KvStorage> initHiveKvStorage({
  String boxName = '@ifl',
  HiveInterface? hive,
  String subDir = 'kv_storage',
}) async {
  final hiveClient = hive ?? Hive;
  if (identical(hiveClient, Hive)) {
    await _ensureDefaultHiveInitialized(subDir);
  }
  final box = await hiveClient.openBox<String>(boxName);
  return HiveKvStorage(HiveBoxAdapter(box));
}

/// Resets Hive init state kept by [initHiveKvStorage].
///
/// For tests only.
@visibleForTesting
void resetHiveKvStorageInitStateForTesting() {
  _isHiveInitialized = false;
  _initializedSubDir = null;
  _hiveInitFuture = null;
}
