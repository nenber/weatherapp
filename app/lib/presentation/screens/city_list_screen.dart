import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_neosilver/blocs/city/city_bloc.dart';
import 'package:weatherapp_neosilver/presentation/widgets/list_city_widget.dart';

class CityListScreen extends StatelessWidget {
  const CityListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.sunny),
          title: const Text('Weather App'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addCity');
          },
          child: const Icon(Icons.add),
        ),
        body: ListCityWidget());
  }
}
