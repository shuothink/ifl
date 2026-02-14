# ifl_example

Demonstrates how to use the ifl plugin.

## Getting Started

This example demonstrates contract-first usage of `KvStorage`.

## What this demo covers
- Implementing `KvStorage` in app side with an in-memory class.
- Basic operations: `write`, `read`, `delete`, `clear`.
- Keeping business code dependent on interface (`KvStorage`) instead of concrete storage engine.

## Notes
- The demo intentionally avoids binding to a specific storage engine.
- Production apps can replace the in-memory implementation with Hive or
  flutter_secure_storage adapters while keeping UI/business flow unchanged.

For Flutter basics, see [Flutter documentation](https://docs.flutter.dev/).
