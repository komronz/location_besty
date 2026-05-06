import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhotoViewerPage extends StatefulWidget {
  final String photoPath;
  final String? heroTag;

  const PhotoViewerPage({super.key, required this.photoPath, this.heroTag});

  static Route<void> route(String photoPath, {String? heroTag}) {
    return PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) =>
          PhotoViewerPage(photoPath: photoPath, heroTag: heroTag),
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 220),
      reverseTransitionDuration: const Duration(milliseconds: 180),
    );
  }

  @override
  State<PhotoViewerPage> createState() => _PhotoViewerPageState();
}

class _PhotoViewerPageState extends State<PhotoViewerPage>
    with SingleTickerProviderStateMixin {
  final _transformCtrl = TransformationController();
  late final _animCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  Animation<Matrix4>? _zoomAnim;
  TapDownDetails? _doubleTapDetails;
  bool _showBars = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _transformCtrl.dispose();
    _animCtrl.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _onDoubleTapDown(TapDownDetails d) => _doubleTapDetails = d;

  void _onDoubleTap() {
    final pos = _doubleTapDetails?.localPosition ?? Offset.zero;
    final isZoomed = _transformCtrl.value.getMaxScaleOnAxis() > 1.5;

    final end = isZoomed
        ? Matrix4.identity()
        : (Matrix4.identity()
          ..translateByDouble(-pos.dx * 2, -pos.dy * 2, 0.0, 1.0)
          ..scaleByDouble(3.0, 3.0, 1.0, 1.0));

    _zoomAnim = Matrix4Tween(begin: _transformCtrl.value, end: end).animate(
      CurvedAnimation(parent: _animCtrl, curve: Curves.easeInOutCubic),
    )..addListener(() => _transformCtrl.value = _zoomAnim!.value);

    _animCtrl.forward(from: 0);
  }

  void _toggleBars() => setState(() => _showBars = !_showBars);

  @override
  Widget build(BuildContext context) {
    final image = Image.file(
      File(widget.photoPath),
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Center(
        child: Icon(Icons.broken_image_rounded,
            color: Colors.white38, size: 72),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: _showBars
          ? AppBar(
              backgroundColor: Colors.black.withValues(alpha: 0.0),
              foregroundColor: Colors.white,
              elevation: 0,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black54, Colors.transparent],
                  ),
                ),
              ),
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.pinch_rounded,
                          color: Colors.white70, size: 14),
                      SizedBox(width: 4),
                      Text('Pinch to zoom',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            )
          : null,
      body: GestureDetector(
        onTap: _toggleBars,
        onDoubleTapDown: _onDoubleTapDown,
        onDoubleTap: _onDoubleTap,
        child: widget.heroTag != null
            ? Hero(
                tag: widget.heroTag!,
                child: InteractiveViewer(
                  transformationController: _transformCtrl,
                  minScale: 0.5,
                  maxScale: 6.0,
                  child: Center(child: image),
                ),
              )
            : InteractiveViewer(
                transformationController: _transformCtrl,
                minScale: 0.5,
                maxScale: 6.0,
                child: Center(child: image),
              ),
      ),
    );
  }
}
