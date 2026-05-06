import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/location.dart';

part 'location_event.freezed.dart';

@freezed
class LocationEvent with _$LocationEvent {
  const factory LocationEvent.loadLocations() = LoadLocationsEvent;

  const factory LocationEvent.addLocation({
    required String name,
    String? description,
    required double latitude,
    required double longitude,
    String? photoPath,
    String? placeName,
  }) = AddLocationEvent;

  const factory LocationEvent.updateLocation(Location location) =
      UpdateLocationEvent;

  const factory LocationEvent.deleteLocation(int id) = DeleteLocationEvent;
}
