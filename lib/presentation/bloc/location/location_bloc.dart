import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/location.dart';
import '../../../domain/repositories/location_repository.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _repository;

  LocationBloc(this._repository) : super(const LocationState.initial()) {
    on<LoadLocationsEvent>(_onLoad);
    on<AddLocationEvent>(_onAdd);
    on<UpdateLocationEvent>(_onUpdate);
    on<DeleteLocationEvent>(_onDelete);
  }

  Future<void> _onLoad(
    LoadLocationsEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationState.loading());
    try {
      final locations = await _repository.getLocations();
      emit(LocationState.loaded(locations));
    } catch (e) {
      emit(LocationState.error(e.toString()));
    }
  }

  Future<void> _onAdd(
    AddLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    try {
      final now = DateTime.now();
      await _repository.addLocation(Location(
        name: event.name,
        description: event.description,
        latitude: event.latitude,
        longitude: event.longitude,
        photoPath: event.photoPath,
        placeName: event.placeName,
        createdAt: now,
        updatedAt: now,
      ));
      final locations = await _repository.getLocations();
      emit(LocationState.loaded(locations));
    } catch (e) {
      emit(LocationState.error(e.toString()));
    }
  }

  Future<void> _onUpdate(
    UpdateLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    try {
      await _repository.updateLocation(event.location);
      final locations = await _repository.getLocations();
      emit(LocationState.loaded(locations));
    } catch (e) {
      emit(LocationState.error(e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    try {
      await _repository.deleteLocation(event.id);
      final locations = await _repository.getLocations();
      emit(LocationState.loaded(locations));
    } catch (e) {
      emit(LocationState.error(e.toString()));
    }
  }
}
