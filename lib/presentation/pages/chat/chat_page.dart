import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/services/openai_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../bloc/location/location_bloc.dart';
import '../../bloc/location/location_event.dart';

// ---------------------------------------------------------------------------
// Models
// ---------------------------------------------------------------------------

class _LocationSuggestion {
  static final _pattern = RegExp(
    r'```location\s*(\{[^`]+\})\s*```',
    dotAll: true,
  );

  final String name;
  final String? description;
  final double latitude;
  final double longitude;

  const _LocationSuggestion({
    required this.name,
    this.description,
    required this.latitude,
    required this.longitude,
  });

  static _LocationSuggestion? tryParse(String text) {
    final match = _pattern.firstMatch(text);
    if (match == null) return null;
    try {
      final json = jsonDecode(match.group(1)!) as Map<String, dynamic>;
      return _LocationSuggestion(
        name: json['name'] as String,
        description: json['description'] as String?,
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
      );
    } catch (_) {
      return null;
    }
  }
}

class _ChatMessage {
  final String id;
  final String displayText;
  final bool isUser;
  final _LocationSuggestion? suggestion;

  _ChatMessage._({
    required this.id,
    required this.displayText,
    required this.isUser,
    this.suggestion,
  });

  factory _ChatMessage.user(String text) => _ChatMessage._(
        id: '${DateTime.now().microsecondsSinceEpoch}',
        displayText: text,
        isUser: true,
      );

  factory _ChatMessage.ai(String rawText) {
    final suggestion = _LocationSuggestion.tryParse(rawText);
    final clean = rawText
        .replaceAll(_LocationSuggestion._pattern, '')
        .trim();
    return _ChatMessage._(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      displayText: clean,
      isUser: false,
      suggestion: suggestion,
    );
  }
}

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _service = OpenAiService();
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final _messages = <_ChatMessage>[];
  final _history = <Map<String, dynamic>>[];
  final _savedIds = <String>{};
  bool _thinking = false;

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _thinking) return;
    _controller.clear();

    final userMsg = _ChatMessage.user(text);
    setState(() {
      _messages.add(userMsg);
      _thinking = true;
    });
    _history.add({'role': 'user', 'content': text});
    _scrollToBottom();

    try {
      final raw = await _service.send(List.from(_history));
      _history.add({'role': 'assistant', 'content': raw});
      final aiMsg = _ChatMessage.ai(raw);
      setState(() => _messages.add(aiMsg));
    } catch (e) {
      setState(() => _messages.add(_ChatMessage.ai(
          'Sorry, something went wrong. Please check your API key and try again.')));
    } finally {
      setState(() => _thinking = false);
      _scrollToBottom();
    }
  }

  void _saveLocation(String msgId, _LocationSuggestion s, String? photoPath) {
    if (_savedIds.contains(msgId)) return;
    setState(() => _savedIds.add(msgId));
    context.read<LocationBloc>().add(LocationEvent.addLocation(
          name: s.name,
          description: s.description,
          latitude: s.latitude,
          longitude: s.longitude,
          photoPath: photoPath,
        ));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.bookmark_added_rounded,
              color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text('"${s.name}" saved to your places',
                style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      backgroundColor: AppTheme.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    ));
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                gradient: AppTheme.gradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome_rounded,
                  color: Colors.white, size: 16),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location AI',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary)),
                Text('Ask me about any place',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppTheme.cardBorder),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _EmptyChat(onSuggestion: (q) {
                    _controller.text = q;
                    _send();
                  })
                : ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    itemCount: _messages.length + (_thinking ? 1 : 0),
                    itemBuilder: (ctx, i) {
                      if (_thinking && i == _messages.length) {
                        return const _ThinkingBubble();
                      }
                      final msg = _messages[i];
                      return msg.isUser
                          ? _UserBubble(text: msg.displayText)
                          : _AiBubble(
                              message: msg,
                              isSaved: _savedIds.contains(msg.id),
                              onSave: (photo) =>
                                  _saveLocation(msg.id, msg.suggestion!, photo),
                            );
                    },
                  ),
          ),
          _InputBar(controller: _controller, thinking: _thinking, onSend: _send),
        ],
      ),
    ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state with suggestion chips
// ---------------------------------------------------------------------------

class _EmptyChat extends StatelessWidget {
  final void Function(String) onSuggestion;
  const _EmptyChat({required this.onSuggestion});

  static const _suggestions = [
    'Suggest a café in Tashkent to save',
    'What are the best viewpoints in Samarkand?',
    'Find me a beach near Charvak',
    'Best rooftop in Tashkent',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 16),
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              gradient: AppTheme.gradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: Colors.white, size: 40),
          ),
          const SizedBox(height: 20),
          const Text('Ask me about any place',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          const Text(
            'Discover locations and save them\ndirectly to your collection.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.5),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _suggestions
                .map((s) => ActionChip(
                      label: Text(s,
                          style: const TextStyle(
                              fontSize: 12, color: AppTheme.primary)),
                      backgroundColor: AppTheme.primary.withValues(alpha: 0.08),
                      side: const BorderSide(
                          color: AppTheme.primary, width: 0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () => onSuggestion(s),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Message bubbles
// ---------------------------------------------------------------------------

class _UserBubble extends StatelessWidget {
  final String text;
  const _UserBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 60),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.primary, AppTheme.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, height: 1.45)),
      ),
    );
  }
}

class _AiBubble extends StatelessWidget {
  final _ChatMessage message;
  final bool isSaved;
  final void Function(String? photoPath) onSave;

  const _AiBubble({
    required this.message,
    required this.isSaved,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, right: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI icon + bubble
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  margin: const EdgeInsets.only(right: 8, bottom: 2),
                  decoration: const BoxDecoration(
                    gradient: AppTheme.gradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.auto_awesome_rounded,
                      color: Colors.white, size: 14),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(18),
                      ),
                      border: Border.all(color: AppTheme.cardBorder),
                    ),
                    child: Text(
                      message.displayText,
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textPrimary,
                          height: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            // Location suggestion card
            if (message.suggestion != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: _LocationCard(
                  suggestion: message.suggestion!,
                  isSaved: isSaved,
                  onSave: onSave,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ThinkingBubble extends StatefulWidget {
  const _ThinkingBubble();

  @override
  State<_ThinkingBubble> createState() => _ThinkingBubbleState();
}

class _ThinkingBubbleState extends State<_ThinkingBubble>
    with SingleTickerProviderStateMixin {
  late final _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 36),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.cardBorder),
        ),
        child: AnimatedBuilder(
          animation: _anim,
          builder: (_, __) => Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              3,
              (i) => _Dot(
                delay: i * 0.2,
                progress: _anim.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double delay;
  final double progress;
  const _Dot({required this.delay, required this.progress});

  @override
  Widget build(BuildContext context) {
    final v = ((progress - delay).clamp(0.0, 0.6) / 0.6);
    return Container(
      width: 7,
      height: 7,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.3 + v * 0.7),
        shape: BoxShape.circle,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Location suggestion card
// ---------------------------------------------------------------------------

class _LocationCard extends StatefulWidget {
  final _LocationSuggestion suggestion;
  final bool isSaved;
  final void Function(String? photoPath) onSave;

  const _LocationCard({
    required this.suggestion,
    required this.isSaved,
    required this.onSave,
  });

  @override
  State<_LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<_LocationCard> {
  String? _photoPath;

  Future<void> _pickPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36, height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 14),
              const Text('Add a Photo',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: AppTheme.primary),
                title: const Text('Take a Photo'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: AppTheme.primary),
                title: const Text('Choose from Gallery'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
    if (source == null) return;

    final picked = await ImagePicker().pickImage(
      source: source, maxWidth: 1920, maxHeight: 1080, imageQuality: 85,
    );
    if (picked == null) return;

    final tmp = File(picked.path);
    if (!await tmp.exists() || await tmp.length() == 0) return;

    try {
      final dir = await getApplicationDocumentsDirectory();
      final dest = '${dir.path}/lb_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await tmp.copy(dest);
      if (mounted) setState(() => _photoPath = dest);
    } catch (_) {
      if (mounted) setState(() => _photoPath = picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.isSaved
              ? AppTheme.primary.withValues(alpha: 0.4)
              : AppTheme.cardBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo area
          if (_photoPath != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.file(
                    File(_photoPath!),
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
                Positioned(
                  top: 8, right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _photoPath = null),
                    child: Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close_rounded,
                          color: Colors.white, size: 15),
                    ),
                  ),
                ),
              ],
            ),
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primary.withValues(alpha: 0.08),
                  AppTheme.primaryLight.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: _photoPath != null
                  ? BorderRadius.zero
                  : const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                const Icon(Icons.place_rounded, size: 16, color: AppTheme.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.suggestion.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.suggestion.description?.isNotEmpty == true) ...[
                  Text(
                    widget.suggestion.description!,
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                        height: 1.4),
                  ),
                  const SizedBox(height: 8),
                ],
                // Coordinates
                Row(
                  children: [
                    _CoordPill(
                        label: 'LAT',
                        value: widget.suggestion.latitude.toStringAsFixed(4)),
                    const SizedBox(width: 6),
                    _CoordPill(
                        label: 'LNG',
                        value: widget.suggestion.longitude.toStringAsFixed(4)),
                  ],
                ),
                const SizedBox(height: 10),
                // Add photo row (only when not yet saved)
                if (!widget.isSaved)
                  GestureDetector(
                    onTap: _pickPhoto,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppTheme.primary.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _photoPath != null
                                ? Icons.check_circle_outline_rounded
                                : Icons.add_a_photo_outlined,
                            size: 14,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _photoPath != null
                                ? 'Photo added — tap to change'
                                : 'Add a photo (optional)',
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: widget.isSaved
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_rounded,
                                  color: Colors.green, size: 16),
                              SizedBox(width: 6),
                              Text('Saved to My Places',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                            ],
                          ),
                        )
                      : Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => widget.onSave(_photoPath),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppTheme.primary, AppTheme.primaryLight],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bookmark_add_rounded,
                                      color: Colors.white, size: 16),
                                  SizedBox(width: 6),
                                  Text('Save to My Places',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoordPill extends StatelessWidget {
  final String label;
  final String value;
  const _CoordPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                  letterSpacing: 0.6)),
          const SizedBox(width: 4),
          Text(value,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Input bar
// ---------------------------------------------------------------------------

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool thinking;
  final VoidCallback onSend;

  const _InputBar({
    required this.controller,
    required this.thinking,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 12, 10 + bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppTheme.cardBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 4,
              minLines: 1,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'Ask about any place…',
                hintStyle: const TextStyle(
                    color: AppTheme.textSecondary, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppTheme.cardBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppTheme.cardBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide:
                      const BorderSide(color: AppTheme.primary, width: 1.5),
                ),
                filled: true,
                fillColor: AppTheme.bg,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: thinking ? null : onSend,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: thinking
                    ? null
                    : const LinearGradient(
                        colors: [AppTheme.primary, AppTheme.primaryLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                color: thinking ? AppTheme.cardBorder : null,
                shape: BoxShape.circle,
                boxShadow: thinking
                    ? null
                    : [
                        BoxShadow(
                          color: AppTheme.primary.withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
              ),
              child: thinking
                  ? const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: AppTheme.primary),
                      ),
                    )
                  : const Icon(Icons.send_rounded,
                      color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
