// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLocations,
    required TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)
        addLocation,
    required TResult Function(Location location) updateLocation,
    required TResult Function(int id) deleteLocation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLocations,
    TResult? Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult? Function(Location location)? updateLocation,
    TResult? Function(int id)? deleteLocation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLocations,
    TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult Function(Location location)? updateLocation,
    TResult Function(int id)? deleteLocation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadLocationsEvent value) loadLocations,
    required TResult Function(AddLocationEvent value) addLocation,
    required TResult Function(UpdateLocationEvent value) updateLocation,
    required TResult Function(DeleteLocationEvent value) deleteLocation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadLocationsEvent value)? loadLocations,
    TResult? Function(AddLocationEvent value)? addLocation,
    TResult? Function(UpdateLocationEvent value)? updateLocation,
    TResult? Function(DeleteLocationEvent value)? deleteLocation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadLocationsEvent value)? loadLocations,
    TResult Function(AddLocationEvent value)? addLocation,
    TResult Function(UpdateLocationEvent value)? updateLocation,
    TResult Function(DeleteLocationEvent value)? deleteLocation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationEventCopyWith<$Res> {
  factory $LocationEventCopyWith(
          LocationEvent value, $Res Function(LocationEvent) then) =
      _$LocationEventCopyWithImpl<$Res, LocationEvent>;
}

/// @nodoc
class _$LocationEventCopyWithImpl<$Res, $Val extends LocationEvent>
    implements $LocationEventCopyWith<$Res> {
  _$LocationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadLocationsEventImplCopyWith<$Res> {
  factory _$$LoadLocationsEventImplCopyWith(_$LoadLocationsEventImpl value,
          $Res Function(_$LoadLocationsEventImpl) then) =
      __$$LoadLocationsEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadLocationsEventImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$LoadLocationsEventImpl>
    implements _$$LoadLocationsEventImplCopyWith<$Res> {
  __$$LoadLocationsEventImplCopyWithImpl(_$LoadLocationsEventImpl _value,
      $Res Function(_$LoadLocationsEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadLocationsEventImpl implements LoadLocationsEvent {
  const _$LoadLocationsEventImpl();

  @override
  String toString() {
    return 'LocationEvent.loadLocations()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadLocationsEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLocations,
    required TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)
        addLocation,
    required TResult Function(Location location) updateLocation,
    required TResult Function(int id) deleteLocation,
  }) {
    return loadLocations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLocations,
    TResult? Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult? Function(Location location)? updateLocation,
    TResult? Function(int id)? deleteLocation,
  }) {
    return loadLocations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLocations,
    TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult Function(Location location)? updateLocation,
    TResult Function(int id)? deleteLocation,
    required TResult orElse(),
  }) {
    if (loadLocations != null) {
      return loadLocations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadLocationsEvent value) loadLocations,
    required TResult Function(AddLocationEvent value) addLocation,
    required TResult Function(UpdateLocationEvent value) updateLocation,
    required TResult Function(DeleteLocationEvent value) deleteLocation,
  }) {
    return loadLocations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadLocationsEvent value)? loadLocations,
    TResult? Function(AddLocationEvent value)? addLocation,
    TResult? Function(UpdateLocationEvent value)? updateLocation,
    TResult? Function(DeleteLocationEvent value)? deleteLocation,
  }) {
    return loadLocations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadLocationsEvent value)? loadLocations,
    TResult Function(AddLocationEvent value)? addLocation,
    TResult Function(UpdateLocationEvent value)? updateLocation,
    TResult Function(DeleteLocationEvent value)? deleteLocation,
    required TResult orElse(),
  }) {
    if (loadLocations != null) {
      return loadLocations(this);
    }
    return orElse();
  }
}

abstract class LoadLocationsEvent implements LocationEvent {
  const factory LoadLocationsEvent() = _$LoadLocationsEventImpl;
}

/// @nodoc
abstract class _$$AddLocationEventImplCopyWith<$Res> {
  factory _$$AddLocationEventImplCopyWith(_$AddLocationEventImpl value,
          $Res Function(_$AddLocationEventImpl) then) =
      __$$AddLocationEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String name,
      String? description,
      double latitude,
      double longitude,
      String? photoPath,
      String? placeName});
}

/// @nodoc
class __$$AddLocationEventImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$AddLocationEventImpl>
    implements _$$AddLocationEventImplCopyWith<$Res> {
  __$$AddLocationEventImplCopyWithImpl(_$AddLocationEventImpl _value,
      $Res Function(_$AddLocationEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? photoPath = freezed,
    Object? placeName = freezed,
  }) {
    return _then(_$AddLocationEventImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      photoPath: freezed == photoPath
          ? _value.photoPath
          : photoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      placeName: freezed == placeName
          ? _value.placeName
          : placeName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AddLocationEventImpl implements AddLocationEvent {
  const _$AddLocationEventImpl(
      {required this.name,
      this.description,
      required this.latitude,
      required this.longitude,
      this.photoPath,
      this.placeName});

  @override
  final String name;
  @override
  final String? description;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? photoPath;
  @override
  final String? placeName;

  @override
  String toString() {
    return 'LocationEvent.addLocation(name: $name, description: $description, latitude: $latitude, longitude: $longitude, photoPath: $photoPath, placeName: $placeName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddLocationEventImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath) &&
            (identical(other.placeName, placeName) ||
                other.placeName == placeName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, description, latitude,
      longitude, photoPath, placeName);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddLocationEventImplCopyWith<_$AddLocationEventImpl> get copyWith =>
      __$$AddLocationEventImplCopyWithImpl<_$AddLocationEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLocations,
    required TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)
        addLocation,
    required TResult Function(Location location) updateLocation,
    required TResult Function(int id) deleteLocation,
  }) {
    return addLocation(
        name, description, latitude, longitude, photoPath, placeName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLocations,
    TResult? Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult? Function(Location location)? updateLocation,
    TResult? Function(int id)? deleteLocation,
  }) {
    return addLocation?.call(
        name, description, latitude, longitude, photoPath, placeName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLocations,
    TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult Function(Location location)? updateLocation,
    TResult Function(int id)? deleteLocation,
    required TResult orElse(),
  }) {
    if (addLocation != null) {
      return addLocation(
          name, description, latitude, longitude, photoPath, placeName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadLocationsEvent value) loadLocations,
    required TResult Function(AddLocationEvent value) addLocation,
    required TResult Function(UpdateLocationEvent value) updateLocation,
    required TResult Function(DeleteLocationEvent value) deleteLocation,
  }) {
    return addLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadLocationsEvent value)? loadLocations,
    TResult? Function(AddLocationEvent value)? addLocation,
    TResult? Function(UpdateLocationEvent value)? updateLocation,
    TResult? Function(DeleteLocationEvent value)? deleteLocation,
  }) {
    return addLocation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadLocationsEvent value)? loadLocations,
    TResult Function(AddLocationEvent value)? addLocation,
    TResult Function(UpdateLocationEvent value)? updateLocation,
    TResult Function(DeleteLocationEvent value)? deleteLocation,
    required TResult orElse(),
  }) {
    if (addLocation != null) {
      return addLocation(this);
    }
    return orElse();
  }
}

abstract class AddLocationEvent implements LocationEvent {
  const factory AddLocationEvent(
      {required final String name,
      final String? description,
      required final double latitude,
      required final double longitude,
      final String? photoPath,
      final String? placeName}) = _$AddLocationEventImpl;

  String get name;
  String? get description;
  double get latitude;
  double get longitude;
  String? get photoPath;
  String? get placeName;

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddLocationEventImplCopyWith<_$AddLocationEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateLocationEventImplCopyWith<$Res> {
  factory _$$UpdateLocationEventImplCopyWith(_$UpdateLocationEventImpl value,
          $Res Function(_$UpdateLocationEventImpl) then) =
      __$$UpdateLocationEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Location location});

  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$UpdateLocationEventImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$UpdateLocationEventImpl>
    implements _$$UpdateLocationEventImplCopyWith<$Res> {
  __$$UpdateLocationEventImplCopyWithImpl(_$UpdateLocationEventImpl _value,
      $Res Function(_$UpdateLocationEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
  }) {
    return _then(_$UpdateLocationEventImpl(
      null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
    ));
  }

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get location {
    return $LocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc

class _$UpdateLocationEventImpl implements UpdateLocationEvent {
  const _$UpdateLocationEventImpl(this.location);

  @override
  final Location location;

  @override
  String toString() {
    return 'LocationEvent.updateLocation(location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateLocationEventImpl &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateLocationEventImplCopyWith<_$UpdateLocationEventImpl> get copyWith =>
      __$$UpdateLocationEventImplCopyWithImpl<_$UpdateLocationEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLocations,
    required TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)
        addLocation,
    required TResult Function(Location location) updateLocation,
    required TResult Function(int id) deleteLocation,
  }) {
    return updateLocation(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLocations,
    TResult? Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult? Function(Location location)? updateLocation,
    TResult? Function(int id)? deleteLocation,
  }) {
    return updateLocation?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLocations,
    TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult Function(Location location)? updateLocation,
    TResult Function(int id)? deleteLocation,
    required TResult orElse(),
  }) {
    if (updateLocation != null) {
      return updateLocation(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadLocationsEvent value) loadLocations,
    required TResult Function(AddLocationEvent value) addLocation,
    required TResult Function(UpdateLocationEvent value) updateLocation,
    required TResult Function(DeleteLocationEvent value) deleteLocation,
  }) {
    return updateLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadLocationsEvent value)? loadLocations,
    TResult? Function(AddLocationEvent value)? addLocation,
    TResult? Function(UpdateLocationEvent value)? updateLocation,
    TResult? Function(DeleteLocationEvent value)? deleteLocation,
  }) {
    return updateLocation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadLocationsEvent value)? loadLocations,
    TResult Function(AddLocationEvent value)? addLocation,
    TResult Function(UpdateLocationEvent value)? updateLocation,
    TResult Function(DeleteLocationEvent value)? deleteLocation,
    required TResult orElse(),
  }) {
    if (updateLocation != null) {
      return updateLocation(this);
    }
    return orElse();
  }
}

abstract class UpdateLocationEvent implements LocationEvent {
  const factory UpdateLocationEvent(final Location location) =
      _$UpdateLocationEventImpl;

  Location get location;

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateLocationEventImplCopyWith<_$UpdateLocationEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteLocationEventImplCopyWith<$Res> {
  factory _$$DeleteLocationEventImplCopyWith(_$DeleteLocationEventImpl value,
          $Res Function(_$DeleteLocationEventImpl) then) =
      __$$DeleteLocationEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$DeleteLocationEventImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$DeleteLocationEventImpl>
    implements _$$DeleteLocationEventImplCopyWith<$Res> {
  __$$DeleteLocationEventImplCopyWithImpl(_$DeleteLocationEventImpl _value,
      $Res Function(_$DeleteLocationEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$DeleteLocationEventImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeleteLocationEventImpl implements DeleteLocationEvent {
  const _$DeleteLocationEventImpl(this.id);

  @override
  final int id;

  @override
  String toString() {
    return 'LocationEvent.deleteLocation(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteLocationEventImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteLocationEventImplCopyWith<_$DeleteLocationEventImpl> get copyWith =>
      __$$DeleteLocationEventImplCopyWithImpl<_$DeleteLocationEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLocations,
    required TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)
        addLocation,
    required TResult Function(Location location) updateLocation,
    required TResult Function(int id) deleteLocation,
  }) {
    return deleteLocation(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLocations,
    TResult? Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult? Function(Location location)? updateLocation,
    TResult? Function(int id)? deleteLocation,
  }) {
    return deleteLocation?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLocations,
    TResult Function(String name, String? description, double latitude,
            double longitude, String? photoPath, String? placeName)?
        addLocation,
    TResult Function(Location location)? updateLocation,
    TResult Function(int id)? deleteLocation,
    required TResult orElse(),
  }) {
    if (deleteLocation != null) {
      return deleteLocation(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadLocationsEvent value) loadLocations,
    required TResult Function(AddLocationEvent value) addLocation,
    required TResult Function(UpdateLocationEvent value) updateLocation,
    required TResult Function(DeleteLocationEvent value) deleteLocation,
  }) {
    return deleteLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadLocationsEvent value)? loadLocations,
    TResult? Function(AddLocationEvent value)? addLocation,
    TResult? Function(UpdateLocationEvent value)? updateLocation,
    TResult? Function(DeleteLocationEvent value)? deleteLocation,
  }) {
    return deleteLocation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadLocationsEvent value)? loadLocations,
    TResult Function(AddLocationEvent value)? addLocation,
    TResult Function(UpdateLocationEvent value)? updateLocation,
    TResult Function(DeleteLocationEvent value)? deleteLocation,
    required TResult orElse(),
  }) {
    if (deleteLocation != null) {
      return deleteLocation(this);
    }
    return orElse();
  }
}

abstract class DeleteLocationEvent implements LocationEvent {
  const factory DeleteLocationEvent(final int id) = _$DeleteLocationEventImpl;

  int get id;

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteLocationEventImplCopyWith<_$DeleteLocationEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
