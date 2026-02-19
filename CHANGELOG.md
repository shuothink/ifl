## 0.0.3

* Added `initHiveKvStorage` in `package:ifl/ifl_hive.dart` so apps can create
  Hive-backed `KvStorage` without manually opening a `Box`.
* `initHiveKvStorage` initializes Hive automatically on first use.
* Added one-time init guard to prevent duplicate concurrent initialization.
* Added `subDir` consistency handling after first initialization (logs and
  ignores new value instead of throwing).
* Added defaults in `initHiveKvStorage`:
  * `boxName = '@ifl'`
  * `subDir = 'kv_storage'`
* Added `resetHiveKvStorageInitStateForTesting()` for test-only state reset.
* Removed public `createHiveKvStorage(Box<String> box)` entrypoint.

## 0.0.2

* Initial release of contract-first storage foundation.
* Added public storage contracts: `Storage`, `KvStorage`, `DatabaseStorage`.
* Added stable entrypoints:
  * `createHiveKvStorage` in `package:ifl/ifl_hive.dart`
  * `createSecureKvStorage` in `package:ifl/ifl_secure.dart`
* Added adapter-based implementations for Hive and flutter_secure_storage.
* Added unit tests for storage contracts and implementation behavior.
* Added contribution and architecture docs.

## 0.0.1

* Initial Flutter plugin template scaffold.
