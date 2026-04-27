import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/location.dart';

part 'location_state.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = LocationInitialState;
  const factory LocationState.loading() = LocationLoadingState;
  const factory LocationState.loaded(List<Location> locations) =
      LocationLoadedState;
  const factory LocationState.error(String message) = LocationErrorState;
}
