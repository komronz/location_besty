import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/location.dart';
import '../../bloc/location/location_bloc.dart';
import '../../bloc/location/location_event.dart';
import '../../bloc/location/location_state.dart';
import '../../widgets/location_card.dart';
import '../detail/detail_page.dart';

class LocationsListPage extends StatefulWidget {
  const LocationsListPage({super.key});

  @override
  State<LocationsListPage> createState() => _LocationsListPageState();
}

class _LocationsListPageState extends State<LocationsListPage> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<Location> _filter(List<Location> all) {
    if (_query.isEmpty) return all;
    final q = _query.toLowerCase();
    return all.where((l) {
      return l.name.toLowerCase().contains(q) ||
          (l.placeName?.toLowerCase().contains(q) ?? false) ||
          (l.description?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        final all = state.maybeMap(
          loaded: (s) => s.locations,
          orElse: () => <Location>[],
        );
        final locations = _filter(all);
        final isLoading =
            state.maybeMap(loading: (_) => true, orElse: () => false);

        return CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            _GradientHeader(
              totalCount: all.length,
              filteredCount: locations.length,
              searchController: _search,
              query: _query,
              onQueryChanged: (v) => setState(() => _query = v),
              onClear: () {
                _search.clear();
                setState(() => _query = '');
              },
            ),
            if (isLoading)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(color: AppTheme.primary),
                ),
              )
            else if (all.isEmpty)
              const SliverFillRemaining(child: _EmptyState())
            else if (locations.isEmpty)
              SliverFillRemaining(child: _NoResults(query: _query))
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => LocationCard(
                      location: locations[i],
                      onTap: () => _openDetail(ctx, locations[i]),
                      onDelete: () => _confirmDelete(ctx, locations[i]),
                    ),
                    childCount: locations.length,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _openDetail(BuildContext context, Location loc) {
    Navigator.push(context, _slide(DetailPage(location: loc)));
  }

  void _confirmDelete(BuildContext context, Location loc) {
    showDialog(
      context: context,
      builder: (ctx) => _DeleteDialog(
        name: loc.name,
        onConfirm: () {
          Navigator.pop(ctx);
          context
              .read<LocationBloc>()
              .add(LocationEvent.deleteLocation(loc.id!));
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _GradientHeader extends StatelessWidget {
  final int totalCount;
  final int filteredCount;
  final TextEditingController searchController;
  final String query;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onClear;

  const _GradientHeader({
    required this.totalCount,
    required this.filteredCount,
    required this.searchController,
    required this.query,
    required this.onQueryChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.gradient,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
        ),
        padding: EdgeInsets.fromLTRB(24, top + 20, 24, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Places',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              query.isNotEmpty
                  ? '$filteredCount of $totalCount ${totalCount == 1 ? 'location' : 'locations'}'
                  : '$totalCount ${totalCount == 1 ? 'location' : 'locations'} saved',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: onQueryChanged,
                style: const TextStyle(
                    color: AppTheme.textPrimary, fontSize: 14),
                cursorColor: AppTheme.primary,
                decoration: InputDecoration(
                  hintText: 'Search places…',
                  hintStyle: const TextStyle(
                      color: AppTheme.textSecondary, fontSize: 14),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: AppTheme.primary, size: 20),
                  suffixIcon: query.isNotEmpty
                      ? GestureDetector(
                          onTap: onClear,
                          child: const Icon(Icons.close_rounded,
                              color: AppTheme.textSecondary, size: 18),
                        )
                      : null,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: AppTheme.gradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(Icons.location_off_rounded,
                  color: Colors.white, size: 44),
            ),
            const SizedBox(height: 24),
            const Text(
              'No places saved yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Head to the Map tab and tap\n"Add Here" to save your first place.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  final String query;
  const _NoResults({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search_off_rounded,
                  color: AppTheme.primary, size: 38),
            ),
            const SizedBox(height: 20),
            const Text('No matches found',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary)),
            const SizedBox(height: 8),
            Text(
              'No saved places match "$query"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                  height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteDialog extends StatelessWidget {
  final String name;
  final VoidCallback onConfirm;
  const _DeleteDialog({required this.name, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Delete Location',
          style: TextStyle(fontWeight: FontWeight.w700)),
      content: Text('Are you sure you want to delete "$name"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size.zero,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: onConfirm,
          child: const Text('Delete'),
        ),
      ],
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
