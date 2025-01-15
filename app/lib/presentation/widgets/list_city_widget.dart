import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_component/weather_builder.dart';
import 'package:weatherapp_neosilver/blocs/city/city_bloc.dart';

class ListCityWidget extends StatefulWidget {
  const ListCityWidget({super.key});

  @override
  State<ListCityWidget> createState() => _ListCityWidgetState();
}

class _ListCityWidgetState extends State<ListCityWidget> {
  final String? apiKey = dotenv.env['WEATHER_API_KEY'];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, CityState>(
      bloc: BlocProvider.of<CityBloc>(context)..add(GetCityListEvent()),
      builder: (context, state) {
        print(state);
        if (state is CityListState) {
          return ListView.builder(
            itemCount: state.cities.length,
            itemBuilder: (context, index) {
              return WeatherBuilder(
                city: state.cities[index].city,
                apiKey: apiKey!,
                builder: (context, weather) {
                  return ListTile(
                    title: Text(state.cities[index].city),
                    subtitle: Text("${weather.main.humidity}% humidity"),
                    trailing: Text("${weather.main.temp}°C"),
                    leading: weather.clouds.all > 50
                        ? const Icon(Icons.cloud)
                        : const Icon(Icons.sunny),
                    onTap: () {
                      Navigator.pushNamed(context, '/cityDetails', arguments: {
                        'city': state.cities[index].city,
                        'weather': weather
                      });
                    },
                  );
                },
                loadingWidget: const Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error) {
                  return ListTile(
                    title: Text(state.cities[index].city),
                    subtitle: Text(
                      'Error: An occured while fetching data',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    leading: const Icon(Icons.error, color: Colors.red),
                  );
                },
              );
            },
          );
        } else {
          return const Center(
            child: Text("No data"),
          );
        }
      },
    );
  }
}
