import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';

@freezed
class Location with _$Location {
  const factory Location({
    int? id,
    required String name,
    String? description,
    required double latitude,
    required double longitude,
    String? photoPath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Location;
}
