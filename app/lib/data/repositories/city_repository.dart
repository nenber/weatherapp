import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_component/weather_component.dart';
import 'package:weatherapp_neosilver/data/models/city.dart';
import "package:collection/collection.dart";

class CityRepository {
  final Dio _dio;
  final CityService _cityService = CityService(dotenv.env['WEATHER_API_KEY']!);
  int limit = 5;
  List<City> cities = [];

  CityRepository(this._dio, [this.limit = 5]) {
    if (this.limit < 5) {
      throw Exception('Limit must be greater than 5');
    }
  }

  Future<List<City>> searchCityList(String city) async {
    try {
      if (city.isEmpty || city.length < 3) {
        return [];
      }
      var result = await _cityService.searchCityByName(city, this.limit);
      return result;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<List<City>> searchCityByCoordinates(double lat, double lon) async {
    try {
      var result = await _cityService.searchCityByCoordinates(lat, lon);
      return result;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<void> addCity(City city) async {
    try {
      //je n'ajoute pas si la ville existe deja

      if (cities.where((x) => x.name == city.name).isEmpty) {
        cities.add(city);
      }
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<List<City>> fetchCityList() async {
    return cities;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> removeCity(String city) async {
    try {
      cities.removeWhere((element) => element.name == city);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
