part of 'city_bloc.dart';

sealed class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class AddCityEvent extends CityEvent {
  final City city;

  const AddCityEvent({required this.city});

  @override
  List<Object> get props => [city];
}

class SearchCityEvent extends CityEvent {
  final String city;

  const SearchCityEvent({required this.city});

  @override
  List<Object> get props => [city];
}

class RemoveCityEvent extends CityEvent {
  final String city;

  const RemoveCityEvent({required this.city});

  @override
  List<Object> get props => [city];
}

class GetCityEvent extends CityEvent {
  final String city;

  const GetCityEvent({required this.city});

  @override
  List<Object> get props => [city];
}

class GetCityListEvent extends CityEvent {
  const GetCityListEvent();

  @override
  List<Object> get props => [];
}

class GetCityByCoordinatesEvent extends CityEvent {
  const GetCityByCoordinatesEvent();

  @override
  List<Object> get props => [];
}
