import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_neosilver/app/Injection_container.dart';
import 'package:weatherapp_neosilver/blocs/city/city_bloc.dart';
import 'router.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<CityBloc>()),
      ],
      child: MaterialApp(
        title: 'Weathapp',
        debugShowCheckedModeBanner: false, // Supprime le bandeau "debug"
        theme: appTheme, // Utilisation du thème défini dans theme.dart
        initialRoute: '/', // Route initiale
        onGenerateRoute: AppRouter.generateRoute, // Gestion des routes
      ),
    );
  }
}
