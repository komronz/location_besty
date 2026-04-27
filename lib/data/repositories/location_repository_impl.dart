import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../database/database_helper.dart';
import '../models/location_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final DatabaseHelper _db;

  LocationRepositoryImpl(this._db);

  @override
  Future<List<Location>> getLocations() async {
    final maps = await _db.queryAll();
    return maps.map((m) => LocationModel.fromMap(m).toEntity()).toList();
  }

  @override
  Future<Location> addLocation(Location location) async {
    final model = LocationModel.fromEntity(location);
    final id = await _db.insert(model.toMap());
    return location.copyWith(id: id);
  }

  @override
  Future<void> updateLocation(Location location) async {
    final updated = location.copyWith(updatedAt: DateTime.now());
    final model = LocationModel.fromEntity(updated);
    await _db.update(model.toMap(), location.id!);
  }

  @override
  Future<void> deleteLocation(int id) async {
    await _db.delete(id);
  }
}
