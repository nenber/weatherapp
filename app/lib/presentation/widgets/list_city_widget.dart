import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp_neosilver/blocs/city/city_bloc.dart';
import 'package:weather_component/src/models/city_model.dart';
import 'package:weather_component/weather_component.dart';

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
        if (state is CityListState) {
          // if (state.cities.isEmpty) {
          //   return Center(
          //     child: const Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: const [
          //         Icon(Icons.info_outline),
          //         SizedBox(height: 16),
          //         Text("No data"),
          //         SizedBox(height: 16),
          //         Text("Add a city to see its weather"),
          //       ],
          //     ),
          //   );
          // }
          return ListView.builder(
            itemCount: state.cities.length,
            itemBuilder: (ctx, index) {
              return WeatherBuilder(
                city: state.cities[index].name,
                apiKey: apiKey!,
                builder: (context, weather) {
                  return ListTile(
                    title: Text(state.cities[index].name),
                    subtitle: Text("${weather.main.humidity ?? 0}% humidity"),
                    trailing: Text("${weather.main.temp ?? 0.0}°C"),
                    leading: weather.clouds.all > 50
                        ? const Icon(Icons.cloud)
                        : const Icon(Icons.sunny),
                    onTap: () {
                      Navigator.pushNamed(context, '/cityDetails', arguments: {
                        'city': state.cities[index].name,
                        'weather': weather
                      });
                    },
                    onLongPress: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: Container(
                            height: 150,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    "Are you sure you want to delete this city?"),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    const SizedBox(width: 16),
                                    TextButton(
                                      onPressed: () {
                                        context.read<CityBloc>().add(
                                            RemoveCityEvent(
                                                city:
                                                    state.cities[index].name));
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Delete",
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                      //delete the city here with popup first
                    },
                  );
                },
                loadingWidget: const Center(child: Text("No data")),
                errorBuilder: (context, error) {
                  return ListTile(
                    title: Text(state.cities[index].name),
                    subtitle: Text(
                      'An error occured while fetching data \n $error',
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

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('This is a typical dialog.'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: const Text('Show Dialog'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog.fullscreen(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('This is a fullscreen dialog.'),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
          child: const Text('Show Fullscreen Dialog'),
        ),
      ],
    );
  }
}
