import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weatherapp_neosilver/data/repositories/city_repository.dart';
import 'package:weather_component/src/models/city_model.dart';
import 'package:geolocator/geolocator.dart';
part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends HydratedBloc<CityEvent, CityState> {
  final CityRepository _cityRepository = CityRepository(Dio(), 5);
  CityBloc() : super(CityInitial()) {
    on<GetCityEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        final cities = await _cityRepository.searchCityList(event.city);
        emit(CityLoadedState(city: cities[0]));
      } catch (e) {
        emit(CityErrorState(message: e.toString()));
      }
    });
    on<GetCityListEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        final cities = await _cityRepository.fetchCityList();
        emit(CityListState(cities: cities));
      } catch (e) {
        emit(CityErrorState(message: e.toString()));
      }
    });
    on<SearchCityEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        final cities = await _cityRepository.searchCityList(event.city);
        emit(CitySearchListState(cities: cities));
      } catch (e) {
        emit(CityErrorState(message: e.toString()));
      }
    });
    on<GetCityByCoordinatesEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        final position = await _cityRepository.determinePosition();
        final cities = await _cityRepository.searchCityByCoordinates(
            position.latitude, position.longitude);
        emit(CitySearchListState(cities: cities));
      } catch (e) {
        emit(CityErrorState(message: e.toString()));
      }
    });
    on<AddCityEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        await _cityRepository.addCity(event.city);
        final result = await _cityRepository.fetchCityList();
        emit(CityListState(cities: result));
      } catch (e) {
        emit(CityErrorState(message: e.toString()));
      }
    });
    on<RemoveCityEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        await _cityRepository.removeCity(event.city);
        final result = await _cityRepository.fetchCityList();
        emit(CityListState(cities: result));
      } catch (e) {
        emit(CityErrorState(message: e.toString()));
      }
    });
  }

  /// Restauration des données depuis le stockage
  @override
  CityState? fromJson(Map<String, dynamic> json) {
    try {
      final citiesJson = json['cities'] as List;
      final cities = citiesJson.map((city) => City.fromJson(city)).toList();

      return CityListState(cities: cities);
    } catch (_) {
      return null;
    }
  }

  /// Sauvegarde des données dans le stockage
  @override
  Map<String, dynamic>? toJson(CityState state) {
    if (state is CityListState) {
      return {
        'cities': state.cities.map((city) => city.toJson()).toList(),
      };
    }
    return null;
  }
}
