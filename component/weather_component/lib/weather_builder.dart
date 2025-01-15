import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:weather_component/src/helpers/constants.dart';

import 'src/models/weather_model.dart';

typedef WeatherWidgetBuilder = Widget Function(
    BuildContext context, Weather weather);
typedef ErrorWidgetBuilder = Widget Function(
    BuildContext context, String error);

class WeatherBuilder extends StatefulWidget {
  final String apiKey;
  final WeatherWidgetBuilder builder;
  final Widget? loadingWidget;
  final ErrorWidgetBuilder? errorBuilder;
  final String city;

  const WeatherBuilder({
    Key? key,
    required this.apiKey,
    required this.builder,
    this.loadingWidget,
    this.errorBuilder,
    required this.city,
  }) : super(key: key);

  @override
  _WeatherBuilderState createState() => _WeatherBuilderState();
}

class _WeatherBuilderState extends State<WeatherBuilder> {
  late Future<Weather> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchWeather();
  }

  Future<Weather> _fetchWeather() async {
    try {
      final dio = Dio();
      final url = Constants.baseUrl;
      final response = await dio.get(url, queryParameters: {
        'q': widget.city,
        'appid': widget.apiKey,
        'units': 'metric',
      });
      return Weather.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget ??
              const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          final error = snapshot.error.toString();
          return widget.errorBuilder != null
              ? widget.errorBuilder!(context, error)
              : Center(child: Text('Error: $error'));
        } else if (snapshot.hasData) {
          return widget.builder(context, snapshot.data!);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
