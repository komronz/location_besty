import '../../domain/entities/location.dart';

class LocationModel {
  final int? id;
  final String name;
  final String? description;
  final double latitude;
  final double longitude;
  final String? photoPath;
  final String? placeName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LocationModel({
    this.id,
    required this.name,
    this.description,
    required this.latitude,
    required this.longitude,
    this.photoPath,
    this.placeName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String?,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      photoPath: map['photo_path'] as String?,
      placeName: map['place_name'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'photo_path': photoPath,
      'place_name': placeName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Location toEntity() => Location(
        id: id,
        name: name,
        description: description,
        latitude: latitude,
        longitude: longitude,
        photoPath: photoPath,
        placeName: placeName,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory LocationModel.fromEntity(Location entity) => LocationModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        latitude: entity.latitude,
        longitude: entity.longitude,
        photoPath: entity.photoPath,
        placeName: entity.placeName,
        createdAt: entity.createdAt ?? DateTime.now(),
        updatedAt: entity.updatedAt ?? DateTime.now(),
      );
}
