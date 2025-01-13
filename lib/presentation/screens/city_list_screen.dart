import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_neosilver/blocs/city/city_bloc.dart';

class CityListScreen extends StatelessWidget {
  const CityListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addCity');
          },
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<CityBloc, CityState>(
          bloc: BlocProvider.of<CityBloc>(context)..add(GetCityListEvent()),
          builder: (context, state) {
            if (state is CityListState) {
              return ListView.builder(
                itemCount: state.cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.cities[index].name),
                    onTap: () {
                      context
                          .read<CityBloc>()
                          .add(GetCityEvent(city: state.cities[index].id));
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
