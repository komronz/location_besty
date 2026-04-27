// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Location> locations) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Location> locations)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Location> locations)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationInitialState value) initial,
    required TResult Function(LocationLoadingState value) loading,
    required TResult Function(LocationLoadedState value) loaded,
    required TResult Function(LocationErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationInitialState value)? initial,
    TResult? Function(LocationLoadingState value)? loading,
    TResult? Function(LocationLoadedState value)? loaded,
    TResult? Function(LocationErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationInitialState value)? initial,
    TResult Function(LocationLoadingState value)? loading,
    TResult Function(LocationLoadedState value)? loaded,
    TResult Function(LocationErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationStateCopyWith<$Res> {
  factory $LocationStateCopyWith(
          LocationState value, $Res Function(LocationState) then) =
      _$LocationStateCopyWithImpl<$Res, LocationState>;
}

/// @nodoc
class _$LocationStateCopyWithImpl<$Res, $Val extends LocationState>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LocationInitialStateImplCopyWith<$Res> {
  factory _$$LocationInitialStateImplCopyWith(_$LocationInitialStateImpl value,
          $Res Function(_$LocationInitialStateImpl) then) =
      __$$LocationInitialStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LocationInitialStateImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LocationInitialStateImpl>
    implements _$$LocationInitialStateImplCopyWith<$Res> {
  __$$LocationInitialStateImplCopyWithImpl(_$LocationInitialStateImpl _value,
      $Res Function(_$LocationInitialStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LocationInitialStateImpl implements LocationInitialState {
  const _$LocationInitialStateImpl();

  @override
  String toString() {
    return 'LocationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationInitialStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Location> locations) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Location> locations)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Location> locations)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationInitialState value) initial,
    required TResult Function(LocationLoadingState value) loading,
    required TResult Function(LocationLoadedState value) loaded,
    required TResult Function(LocationErrorState value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationInitialState value)? initial,
    TResult? Function(LocationLoadingState value)? loading,
    TResult? Function(LocationLoadedState value)? loaded,
    TResult? Function(LocationErrorState value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationInitialState value)? initial,
    TResult Function(LocationLoadingState value)? loading,
    TResult Function(LocationLoadedState value)? loaded,
    TResult Function(LocationErrorState value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class LocationInitialState implements LocationState {
  const factory LocationInitialState() = _$LocationInitialStateImpl;
}

/// @nodoc
abstract class _$$LocationLoadingStateImplCopyWith<$Res> {
  factory _$$LocationLoadingStateImplCopyWith(_$LocationLoadingStateImpl value,
          $Res Function(_$LocationLoadingStateImpl) then) =
      __$$LocationLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LocationLoadingStateImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LocationLoadingStateImpl>
    implements _$$LocationLoadingStateImplCopyWith<$Res> {
  __$$LocationLoadingStateImplCopyWithImpl(_$LocationLoadingStateImpl _value,
      $Res Function(_$LocationLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LocationLoadingStateImpl implements LocationLoadingState {
  const _$LocationLoadingStateImpl();

  @override
  String toString() {
    return 'LocationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Location> locations) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Location> locations)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Location> locations)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationInitialState value) initial,
    required TResult Function(LocationLoadingState value) loading,
    required TResult Function(LocationLoadedState value) loaded,
    required TResult Function(LocationErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationInitialState value)? initial,
    TResult? Function(LocationLoadingState value)? loading,
    TResult? Function(LocationLoadedState value)? loaded,
    TResult? Function(LocationErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationInitialState value)? initial,
    TResult Function(LocationLoadingState value)? loading,
    TResult Function(LocationLoadedState value)? loaded,
    TResult Function(LocationErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LocationLoadingState implements LocationState {
  const factory LocationLoadingState() = _$LocationLoadingStateImpl;
}

/// @nodoc
abstract class _$$LocationLoadedStateImplCopyWith<$Res> {
  factory _$$LocationLoadedStateImplCopyWith(_$LocationLoadedStateImpl value,
          $Res Function(_$LocationLoadedStateImpl) then) =
      __$$LocationLoadedStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Location> locations});
}

/// @nodoc
class __$$LocationLoadedStateImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LocationLoadedStateImpl>
    implements _$$LocationLoadedStateImplCopyWith<$Res> {
  __$$LocationLoadedStateImplCopyWithImpl(_$LocationLoadedStateImpl _value,
      $Res Function(_$LocationLoadedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locations = null,
  }) {
    return _then(_$LocationLoadedStateImpl(
      null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<Location>,
    ));
  }
}

/// @nodoc

class _$LocationLoadedStateImpl implements LocationLoadedState {
  const _$LocationLoadedStateImpl(final List<Location> locations)
      : _locations = locations;

  final List<Location> _locations;
  @override
  List<Location> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  String toString() {
    return 'LocationState.loaded(locations: $locations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationLoadedStateImpl &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_locations));

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationLoadedStateImplCopyWith<_$LocationLoadedStateImpl> get copyWith =>
      __$$LocationLoadedStateImplCopyWithImpl<_$LocationLoadedStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Location> locations) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(locations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Location> locations)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(locations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Location> locations)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(locations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationInitialState value) initial,
    required TResult Function(LocationLoadingState value) loading,
    required TResult Function(LocationLoadedState value) loaded,
    required TResult Function(LocationErrorState value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationInitialState value)? initial,
    TResult? Function(LocationLoadingState value)? loading,
    TResult? Function(LocationLoadedState value)? loaded,
    TResult? Function(LocationErrorState value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationInitialState value)? initial,
    TResult Function(LocationLoadingState value)? loading,
    TResult Function(LocationLoadedState value)? loaded,
    TResult Function(LocationErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LocationLoadedState implements LocationState {
  const factory LocationLoadedState(final List<Location> locations) =
      _$LocationLoadedStateImpl;

  List<Location> get locations;

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationLoadedStateImplCopyWith<_$LocationLoadedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationErrorStateImplCopyWith<$Res> {
  factory _$$LocationErrorStateImplCopyWith(_$LocationErrorStateImpl value,
          $Res Function(_$LocationErrorStateImpl) then) =
      __$$LocationErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$LocationErrorStateImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LocationErrorStateImpl>
    implements _$$LocationErrorStateImplCopyWith<$Res> {
  __$$LocationErrorStateImplCopyWithImpl(_$LocationErrorStateImpl _value,
      $Res Function(_$LocationErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$LocationErrorStateImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LocationErrorStateImpl implements LocationErrorState {
  const _$LocationErrorStateImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'LocationState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationErrorStateImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationErrorStateImplCopyWith<_$LocationErrorStateImpl> get copyWith =>
      __$$LocationErrorStateImplCopyWithImpl<_$LocationErrorStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Location> locations) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Location> locations)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Location> locations)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocationInitialState value) initial,
    required TResult Function(LocationLoadingState value) loading,
    required TResult Function(LocationLoadedState value) loaded,
    required TResult Function(LocationErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocationInitialState value)? initial,
    TResult? Function(LocationLoadingState value)? loading,
    TResult? Function(LocationLoadedState value)? loaded,
    TResult? Function(LocationErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocationInitialState value)? initial,
    TResult Function(LocationLoadingState value)? loading,
    TResult Function(LocationLoadedState value)? loaded,
    TResult Function(LocationErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class LocationErrorState implements LocationState {
  const factory LocationErrorState(final String message) =
      _$LocationErrorStateImpl;

  String get message;

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationErrorStateImplCopyWith<_$LocationErrorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
