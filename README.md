# ifl

Contract-first storage foundation for Flutter apps.

## Public API

- `package:ifl/ifl.dart`
  - Contracts only (`Storage`, `KvStorage`, `DatabaseStorage`)
- `package:ifl/ifl_hive.dart`
  - Stable Hive entrypoint (`createHiveKvStorage`)
- `package:ifl/ifl_secure.dart`
  - Stable secure storage entrypoint (`createSecureKvStorage`)

## Example: use Hive + Secure KV together

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ifl/ifl.dart';
import 'package:ifl/ifl_hive.dart';
import 'package:ifl/ifl_secure.dart';

Future<void> setupStorage() async {
  await Hive.initFlutter();

  final hiveBox = await Hive.openBox<String>('app_cache');
  final KvStorage hiveKv = createHiveKvStorage(hiveBox);
  final KvStorage secureKv = createSecureKvStorage(
    name: 'secure_user',
    storage: const FlutterSecureStorage(),
  );

  await secureKv.write('token', 'xxx');
  await hiveKv.write('profile', '{"name":"if"}');
}
```

## Notes

- Avoid importing `package:ifl/src/...` directly in app code.
- Keep business code dependent on `KvStorage` contract, not concrete engines.
