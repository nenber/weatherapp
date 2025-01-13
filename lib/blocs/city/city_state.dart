part of 'city_bloc.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

final class CityInitial extends CityState {}

class CityListState extends CityState {
  final List<City> cities;

  const CityListState({required this.cities});

  @override
  List<Object> get props => [cities];
}

class CityErrorState extends CityState {
  final String message;

  const CityErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class CityLoadingState extends CityState {}

class CityLoadedState extends CityState {
  final City city;

  const CityLoadedState({required this.city});

  @override
  List<Object> get props => [city];
}
