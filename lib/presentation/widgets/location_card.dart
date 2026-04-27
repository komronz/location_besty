import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const LocationCard({
    super.key,
    required this.location,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _Thumbnail(location: location),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.2,
                        ),
                      ),
                      if (location.description?.isNotEmpty == true) ...[
                        const SizedBox(height: 3),
                        Text(
                          location.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      _CoordChip(
                        lat: location.latitude,
                        lng: location.longitude,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.chevron_right_rounded,
                        color: AppTheme.textSecondary, size: 20),
                    const SizedBox(height: 8),
                    _DeleteButton(onDelete: onDelete),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final Location location;
  const _Thumbnail({required this.location});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 72,
        height: 72,
        child: location.photoPath != null
            ? Image.file(
                File(location.photoPath!),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _gradient(),
              )
            : _gradient(),
      ),
    );
  }

  Widget _gradient() => Container(
        decoration: const BoxDecoration(gradient: AppTheme.gradient),
        child: const Icon(Icons.location_on_rounded,
            color: Colors.white, size: 30),
      );
}

class _CoordChip extends StatelessWidget {
  final double lat;
  final double lng;
  const _CoordChip({required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on, size: 11, color: AppTheme.primary),
          const SizedBox(width: 3),
          Text(
            '${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}',
            style: const TextStyle(
                fontSize: 11,
                color: AppTheme.primary,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback onDelete;
  const _DeleteButton({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDelete,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.delete_outline_rounded,
            color: Colors.red.shade400, size: 16),
      ),
    );
  }
}
