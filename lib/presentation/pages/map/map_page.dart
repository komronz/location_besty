import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/location.dart';
import '../../bloc/location/location_bloc.dart';
import '../../bloc/location/location_state.dart';
import '../add_edit/add_edit_page.dart';
import '../detail/detail_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _ctrl;

  static const _defaultPos = CameraPosition(
    target: LatLng(41.2995, 69.2401),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _GlassAppBar(),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return GoogleMap(
            initialCameraPosition: _defaultPos,
            onMapCreated: (c) {
              _ctrl = c;
              _goToCurrentLocation();
            },
            markers: _buildMarkers(state, context),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onLongPress: (ll) =>
                _openAdd(context, lat: ll.latitude, lng: ll.longitude),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 60,
              bottom: 100,
            ),
          );
        },
      ),
      floatingActionButton: _GradientFab(
        onTap: () => _addAtCurrentPosition(context),
      ),
    );
  }

  Set<Marker> _buildMarkers(LocationState state, BuildContext context) {
    final locs = state.maybeMap(loaded: (s) => s.locations, orElse: () => <Location>[]);
    return {
      for (final loc in locs)
        Marker(
          markerId: MarkerId(loc.id.toString()),
          position: LatLng(loc.latitude, loc.longitude),
          infoWindow: InfoWindow(
            title: loc.name,
            snippet: loc.description ?? 'Tap to view',
            onTap: () => Navigator.push(
              context,
              _slide(DetailPage(location: loc)),
            ),
          ),
        ),
    };
  }

  Future<void> _goToCurrentLocation() async {
    final pos = await _getPosition();
    if (pos != null && _ctrl != null) {
      _ctrl!.animateCamera(
        CameraUpdate.newLatLng(LatLng(pos.latitude, pos.longitude)),
      );
    }
  }

  Future<void> _addAtCurrentPosition(BuildContext context) async {
    final pos = await _getPosition();
    if (!context.mounted) return;
    _openAdd(context,
        lat: pos?.latitude ?? 41.2995, lng: pos?.longitude ?? 69.2401);
  }

  void _openAdd(BuildContext context,
      {required double lat, required double lng}) {
    Navigator.push(
      context,
      _slide(AddEditPage(initialLatitude: lat, initialLongitude: lng)),
    );
  }

  Future<Position?> _getPosition() async {
    try {
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.deniedForever) return null;
      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }
}

// ---------------------------------------------------------------------------

class _GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              gradient: AppTheme.gradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.location_on_rounded,
                color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          const Text(
            'Location Besty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientFab extends StatelessWidget {
  final VoidCallback onTap;
  const _GradientFab({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.primaryLight],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_location_alt_rounded,
                    color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Add Here',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

PageRouteBuilder<void> _slide(Widget page) => PageRouteBuilder(
      pageBuilder: (_, a, b) => page,
      transitionsBuilder: (_, a, __, child) => SlideTransition(
        position: Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 300),
    );
