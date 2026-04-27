import 'package:get_it/get_it.dart';
import '../../data/database/database_helper.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/location_repository.dart';
import '../../presentation/bloc/location/location_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final dbHelper = DatabaseHelper();
  await dbHelper.database; // initialise the DB file on first run

  getIt.registerSingleton<DatabaseHelper>(dbHelper);

  getIt.registerSingleton<LocationRepository>(
    LocationRepositoryImpl(getIt<DatabaseHelper>()),
  );

  getIt.registerFactory<LocationBloc>(
    () => LocationBloc(getIt<LocationRepository>()),
  );
}
