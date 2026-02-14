import 'storage.dart';

/// Marker contract for future database-style storage capabilities.
///
/// Keep this as a boundary type so database implementations can be introduced
/// later without changing import paths for consumers.
abstract interface class DatabaseStorage implements Storage {}
