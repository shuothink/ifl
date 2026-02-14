## 0.0.1

* Initial release of contract-first storage foundation.
* Added public storage contracts: `Storage`, `KvStorage`, `DatabaseStorage`.
* Added stable entrypoints:
  * `createHiveKvStorage` in `package:ifl/ifl_hive.dart`
  * `createSecureKvStorage` in `package:ifl/ifl_secure.dart`
* Added adapter-based implementations for Hive and flutter_secure_storage.
* Added unit tests for storage contracts and implementation behavior.
