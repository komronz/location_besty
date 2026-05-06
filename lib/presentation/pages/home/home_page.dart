import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../chat/chat_page.dart';
import '../map/map_page.dart';
import '../locations_list/list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  static const _pages = <Widget>[
    MapPage(),
    LocationsListPage(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.map_outlined,
                  color: _index == 0
                      ? AppTheme.primary
                      : AppTheme.textSecondary),
              selectedIcon:
                  const Icon(Icons.map_rounded, color: AppTheme.primary),
              label: 'Map',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_border_rounded,
                  color: _index == 1
                      ? AppTheme.primary
                      : AppTheme.textSecondary),
              selectedIcon: const Icon(Icons.bookmark_rounded,
                  color: AppTheme.primary),
              label: 'Saved',
            ),
            NavigationDestination(
              icon: Icon(Icons.auto_awesome_outlined,
                  color: _index == 2
                      ? AppTheme.primary
                      : AppTheme.textSecondary),
              selectedIcon: const Icon(Icons.auto_awesome_rounded,
                  color: AppTheme.primary),
              label: 'AI Chat',
            ),
          ],
        ),
      ),
    );
  }
}
