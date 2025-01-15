import 'package:get_it/get_it.dart';
import 'package:weatherapp_neosilver/blocs/city/city_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => CityBloc());
}
