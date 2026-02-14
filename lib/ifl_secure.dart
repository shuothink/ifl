library ifl_secure;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'ifl.dart';
import 'src/storage/impl/secure/flutter_secure_storage_client_adapter.dart';
import 'src/storage/impl/secure/flutter_secure_storage_kv_storage.dart';

/// Creates a secure [KvStorage] backed by [FlutterSecureStorage].
///
/// Keys are namespaced by [name] to isolate different logical storage domains.
KvStorage createSecureKvStorage({
  required String name,
  FlutterSecureStorage? storage,
}) {
  return FlutterSecureStorageKvStorage(
    name: name,
    client: FlutterSecureStorageClientAdapter(
      storage ?? const FlutterSecureStorage(),
    ),
  );
}
