import '../entities/location.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocations();
  Future<Location> addLocation(Location location);
  Future<void> updateLocation(Location location);
  Future<void> deleteLocation(int id);
}
