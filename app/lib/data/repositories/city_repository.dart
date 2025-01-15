import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp_neosilver/data/models/city.dart';
import "package:collection/collection.dart";

class CityRepository {
  final Dio _dio;
  final String? _baseUrl = dotenv.env['GEOCODING_BASE_URL'];
  int limit = 5;
  List<City> cities = [];

  CityRepository(this._dio, [this.limit = 10]) {
    if (_baseUrl == null) {
      throw Exception('Base URL is not set');
    }
    if (this.limit < 5) {
      throw Exception('Limit must be greater than 5');
    }
    _dio.options.baseUrl = _baseUrl;
  }

  Future<List<City>> searchCityList(String city) async {
    try {
      if (city.isEmpty || city.length < 3) {
        return [];
      }

      final response = await _dio.get('/search/?q=$city&limit=$limit');
      final List<dynamic> features = response.data["features"];

      // Conversion explicite de chaque élément en `City`
      final List<City> result = features
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList();
      final grouped = groupBy(result, (e) => e.citycode);
      final List<City> result2 = grouped.values.map((e) => e.first).toList();
      return result2;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<void> addCity(City city) async {
    try {
      //je n'ajoute pas si la ville existe deja

      if (cities.where((x) => x.id == city.id).isEmpty) {
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
}
