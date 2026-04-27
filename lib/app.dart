import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'presentation/bloc/location/location_bloc.dart';
import 'presentation/bloc/location/location_event.dart';
import 'presentation/pages/home/home_page.dart';

class LocationBestyApp extends StatelessWidget {
  const LocationBestyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<LocationBloc>()..add(const LocationEvent.loadLocations()),
      child: MaterialApp(
        title: 'Location Besty',
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
