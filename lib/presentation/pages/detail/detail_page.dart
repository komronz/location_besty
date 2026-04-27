import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/location.dart';
import '../../bloc/location/location_bloc.dart';
import '../../bloc/location/location_event.dart';
import '../add_edit/add_edit_page.dart';

class DetailPage extends StatelessWidget {
  final Location location;
  const DetailPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: CustomScrollView(
        slivers: [
          _HeroAppBar(location: location),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (location.description?.isNotEmpty == true)
                    _InfoCard(
                      icon: Icons.notes_rounded,
                      title: 'Description',
                      child: Text(
                        location.description!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ),
                  _InfoCard(
                    icon: Icons.location_on_rounded,
                    title: 'Coordinates',
                    child: Row(
                      children: [
                        _CoordBadge(
                          label: 'LAT',
                          value: location.latitude.toStringAsFixed(6),
                        ),
                        const SizedBox(width: 10),
                        _CoordBadge(
                          label: 'LNG',
                          value: location.longitude.toStringAsFixed(6),
                        ),
                      ],
                    ),
                  ),
                  _InfoCard(
                    icon: Icons.map_rounded,
                    title: 'Map',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: SizedBox(
                        height: 220,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target:
                                LatLng(location.latitude, location.longitude),
                            zoom: 15,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId('loc'),
                              position: LatLng(
                                  location.latitude, location.longitude),
                              infoWindow:
                                  InfoWindow(title: location.name),
                            ),
                          },
                          scrollGesturesEnabled: false,
                          zoomGesturesEnabled: false,
                          rotateGesturesEnabled: false,
                          tiltGesturesEnabled: false,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                        ),
                      ),
                    ),
                  ),
                  if (location.createdAt != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_rounded,
                              size: 14, color: AppTheme.textSecondary),
                          const SizedBox(width: 6),
                          Text(
                            'Saved on ${_fmt(location.createdAt!)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  _ActionButtons(location: location),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }
}

// ---------------------------------------------------------------------------

class _HeroAppBar extends StatelessWidget {
  final Location location;
  const _HeroAppBar({required this.location});

  @override
  Widget build(BuildContext context) {
    final hasPhoto = location.photoPath != null;
    return SliverAppBar(
      expandedHeight: hasPhoto ? 300 : 180,
      pinned: true,
      backgroundColor: AppTheme.primary,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit_rounded, size: 18),
          ),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, a, b) => AddEditPage(location: location),
              transitionsBuilder: (_, a, __, child) => SlideTransition(
                position: Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(
                    CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
                child: child,
              ),
              transitionDuration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        title: Text(
          location.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            shadows: [Shadow(blurRadius: 6, color: Colors.black38)],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            hasPhoto
                ? Image.file(
                    File(location.photoPath!),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      decoration:
                          const BoxDecoration(gradient: AppTheme.gradient),
                      child: const Icon(Icons.location_on_rounded,
                          size: 80, color: Colors.white24),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(gradient: AppTheme.gradient),
                    child: const Icon(Icons.location_on_rounded,
                        size: 80, color: Colors.white24),
                  ),
            // Gradient overlay for readability
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.55),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _InfoCard(
      {required this.icon, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  gradient: AppTheme.gradient,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _CoordBadge extends StatelessWidget {
  final String label;
  final String value;

  const _CoordBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                  letterSpacing: 0.8),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final Location location;
  const _ActionButtons({required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _GradientBtn(
            icon: Icons.edit_rounded,
            label: 'Edit',
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, a, b) => AddEditPage(location: location),
                transitionsBuilder: (_, a, __, child) => SlideTransition(
                  position: Tween(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                      parent: a, curve: Curves.easeOutCubic)),
                  child: child,
                ),
                transitionDuration: const Duration(milliseconds: 300),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _DeleteBtn(
            onTap: () => _confirmDelete(context),
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete?',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: Text('Remove "${location.name}" permanently?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size.zero,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              context
                  .read<LocationBloc>()
                  .add(LocationEvent.deleteLocation(location.id!));
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _GradientBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _GradientBtn(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [AppTheme.primary, AppTheme.primaryLight]),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _DeleteBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_outline_rounded,
                  color: Colors.red.shade400, size: 18),
              const SizedBox(width: 6),
              Text('Delete',
                  style: TextStyle(
                      color: Colors.red.shade400,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
