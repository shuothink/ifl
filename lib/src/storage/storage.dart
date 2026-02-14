/// Base contract for any storage capability.
abstract interface class Storage {
  /// Logical storage identifier, e.g. `secure_user` or `app_cache`.
  String get name;

  /// Releases underlying resources.
  Future<void> close();
}
