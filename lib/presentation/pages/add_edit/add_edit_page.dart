import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/location.dart';
import '../../bloc/location/location_bloc.dart';
import '../../bloc/location/location_event.dart';

class AddEditPage extends StatefulWidget {
  final Location? location;
  final double? initialLatitude;
  final double? initialLongitude;

  const AddEditPage({
    super.key,
    this.location,
    this.initialLatitude,
    this.initialLongitude,
  });

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _desc;
  String? _photoPath;
  late double _lat;
  late double _lng;
  bool _saving = false;

  bool get _isEdit => widget.location != null;

  @override
  void initState() {
    super.initState();
    final loc = widget.location;
    _name = TextEditingController(text: loc?.name ?? '');
    _desc = TextEditingController(text: loc?.description ?? '');
    _photoPath = loc?.photoPath;
    _lat = loc?.latitude ?? widget.initialLatitude ?? 41.2995;
    _lng = loc?.longitude ?? widget.initialLongitude ?? 69.2401;
  }

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: AppTheme.bg,
        title: Text(_isEdit ? 'Edit Location' : 'New Location'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _Section(
              icon: Icons.camera_alt_outlined,
              label: 'Photo',
              child: _PhotoPicker(
                photoPath: _photoPath,
                onChanged: (p) => setState(() => _photoPath = p),
              ),
            ),
            _Section(
              icon: Icons.info_outline_rounded,
              label: 'Details',
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Name *',
                      prefixIcon: Icon(Icons.label_outline),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Name is required'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _desc,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                      prefixIcon: Icon(Icons.notes_outlined),
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
            _Section(
              icon: Icons.location_on_outlined,
              label: 'Location',
              child: _MapPicker(
                lat: _lat,
                lng: _lng,
                onChanged: (lat, lng) =>
                    setState(() { _lat = lat; _lng = lng; }),
              ),
            ),
            const SizedBox(height: 8),
            _GradientButton(
              label: _isEdit ? 'Update Location' : 'Save Location',
              loading: _saving,
              onTap: _saving ? null : _save,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final bloc = context.read<LocationBloc>();
    // _photoPath is already in Documents dir (copied at pick time)
    final name = _name.text.trim();
    final desc = _desc.text.trim().isEmpty ? null : _desc.text.trim();

    if (_isEdit) {
      bloc.add(LocationEvent.updateLocation(
        widget.location!.copyWith(
          name: name,
          description: desc,
          latitude: _lat,
          longitude: _lng,
          photoPath: _photoPath,
          updatedAt: DateTime.now(),
        ),
      ));
    } else {
      bloc.add(LocationEvent.addLocation(
        name: name,
        description: desc,
        latitude: _lat,
        longitude: _lng,
        photoPath: _photoPath,
      ));
    }

    if (mounted) Navigator.pop(context);
  }

}

// ---------------------------------------------------------------------------
// Section card
// ---------------------------------------------------------------------------

class _Section extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;

  const _Section(
      {required this.icon, required this.label, required this.child});

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
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: AppTheme.gradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Gradient button
// ---------------------------------------------------------------------------

class _GradientButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onTap;

  const _GradientButton(
      {required this.label, required this.loading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        gradient: onTap == null
            ? null
            : const LinearGradient(
                colors: [AppTheme.primary, AppTheme.primaryLight]),
        color: onTap == null ? Colors.grey.shade300 : null,
        borderRadius: BorderRadius.circular(16),
        boxShadow: onTap == null
            ? null
            : [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5),
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Photo picker
// ---------------------------------------------------------------------------

class _PhotoPicker extends StatelessWidget {
  final String? photoPath;
  final ValueChanged<String?> onChanged;

  const _PhotoPicker({required this.photoPath, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pick(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.bg,
            border: Border.all(
              color: AppTheme.primary.withValues(alpha: 0.25),
              width: 1.5,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: photoPath != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      File(photoPath!),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        decoration:
                            const BoxDecoration(gradient: AppTheme.gradient),
                        child: const Icon(Icons.broken_image_rounded,
                            color: Colors.white54, size: 48),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _CloseButton(onTap: () => onChanged(null)),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: AppTheme.gradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.add_a_photo_rounded,
                          color: Colors.white, size: 28),
                    ),
                    const SizedBox(height: 12),
                    const Text('Tap to add a photo',
                        style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    const SizedBox(height: 3),
                    const Text('Camera or Gallery',
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12)),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Add Photo',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary)),
            const SizedBox(height: 16),
            _PickerOption(
              icon: Icons.camera_alt_rounded,
              label: 'Take a Photo',
              sub: 'Use your camera',
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            const SizedBox(height: 10),
            _PickerOption(
              icon: Icons.photo_library_rounded,
              label: 'Choose from Gallery',
              sub: 'Pick from your photos',
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;
    final picked = await ImagePicker().pickImage(
        source: source, maxWidth: 1920, maxHeight: 1080, imageQuality: 85);
    if (picked == null) return;

    final tmp = File(picked.path);
    if (!await tmp.exists() || await tmp.length() == 0) return;

    // Copy immediately to Documents so the path survives app restarts
    try {
      final dir = await getApplicationDocumentsDirectory();
      final dest =
          '${dir.path}/lb_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await tmp.copy(dest);
      onChanged(dest);
    } catch (_) {
      // fallback: use the temp path for this session
      onChanged(picked.path);
    }
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.close_rounded, color: Colors.white, size: 16),
      ),
    );
  }
}

class _PickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  final VoidCallback onTap;

  const _PickerOption(
      {required this.icon,
      required this.label,
      required this.sub,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  gradient: AppTheme.gradient, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppTheme.textPrimary)),
                Text(sub,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mini map picker
// ---------------------------------------------------------------------------

class _MapPicker extends StatefulWidget {
  final double lat;
  final double lng;
  final void Function(double lat, double lng) onChanged;

  const _MapPicker(
      {required this.lat, required this.lng, required this.onChanged});

  @override
  State<_MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<_MapPicker> {
  GoogleMapController? _ctrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, size: 13, color: AppTheme.primary),
              const SizedBox(width: 5),
              Text(
                '${widget.lat.toStringAsFixed(5)}, ${widget.lng.toStringAsFixed(5)}',
                style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            height: 180,
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 15),
              onMapCreated: (c) => _ctrl = c,
              markers: {
                Marker(
                  markerId: const MarkerId('pick'),
                  position: LatLng(widget.lat, widget.lng),
                ),
              },
              onTap: (ll) {
                widget.onChanged(ll.latitude, ll.longitude);
                _ctrl?.animateCamera(CameraUpdate.newLatLng(ll));
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
        const SizedBox(height: 6),
        const Text(
          'Tap the map to move the pin',
          style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}
