import 'package:dio/dio.dart';
import 'package:weather_component/src/helpers/constants.dart';
import 'package:weather_component/src/models/city_model.dart';
import 'package:collection/collection.dart';

class CityService {
  final String baseUrl = Constants.baseUrlCitySearch;
  final String baseUrlCoordinates = Constants.baseUrlReverseSearch;
  final Dio _dio = Dio();
  final String apiKey;
  CityService(this.apiKey);

  Future<List<City>> searchCityByName(String city, [int limit = 20]) async {
    try {
      final response = await _dio.get(baseUrl, queryParameters: {
        'q': '$city,,fr',
        'limit': limit,
        'appid': apiKey,
      });

      final List<dynamic> data = response.data;

      final List<City> result =
          data.map((e) => City.fromJson(e as Map<String, dynamic>)).toList();

      // final uniqueCities = result
      //     .fold<Map<String, City>>({}, (map, city) {
      //       map[city.name] = city;
      //       return map;
      //     })
      //     .values
      //     .toList();

      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<City>> searchCityByCoordinates(double lat, double lon) async {
    try {
      final response = await _dio.get(baseUrlCoordinates, queryParameters: {
        'lat': lat,
        'lon': lon,
        'limit': 5,
        'appid': apiKey,
      });
      final List<dynamic> data = response.data;

      final List<City> result =
          data.map((e) => City.fromJson(e as Map<String, dynamic>)).toList();

      final uniqueCities = result
          .fold<Map<String, City>>({}, (map, city) {
            map[city.name] = city;
            return map;
          })
          .values
          .toList();

      return uniqueCities;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
