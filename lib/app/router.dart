import 'package:flutter/material.dart';
import 'package:weatherapp_neosilver/presentation/screens/add_city_screen.dart';
import 'package:weatherapp_neosilver/presentation/screens/city_details_screen.dart';
import 'package:weatherapp_neosilver/presentation/screens/city_list_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const CityListScreen());
      case '/addCity':
        return MaterialPageRoute(builder: (_) => const AddCityScreen());
      case '/cityDetails':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CityDetailsScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
