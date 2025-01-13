class Weather {
  final double latitude;
  final double longitude;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;

  Weather({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  /// Convertit un JSON en objet Weather
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lon'] as num).toDouble(),
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: CurrentWeather.fromJson(json['current']),
      hourly: (json['hourly'] as List)
          .map((hour) => HourlyWeather.fromJson(hour))
          .toList(),
      daily: (json['daily'] as List)
          .map((day) => DailyWeather.fromJson(day))
          .toList(),
    );
  }

  /// Convertit un objet Weather en JSON
  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'lon': longitude,
      'timezone': timezone,
      'timezone_offset': timezoneOffset,
      'current': current.toJson(),
      'hourly': hourly.map((hour) => hour.toJson()).toList(),
      'daily': daily.map((day) => day.toJson()).toList(),
    };
  }
}

class CurrentWeather {
  final int timestamp;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDegree;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;

  CurrentWeather({
    required this.timestamp,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDegree,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      timestamp: json['dt'],
      temperature: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      humidity: json['humidity'],
      pressure: json['pressure'],
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windDegree: json['wind_deg'],
      weatherMain: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': timestamp,
      'temp': temperature,
      'feels_like': feelsLike,
      'humidity': humidity,
      'pressure': pressure,
      'wind_speed': windSpeed,
      'wind_deg': windDegree,
      'weather': [
        {
          'main': weatherMain,
          'description': weatherDescription,
          'icon': weatherIcon,
        }
      ],
    };
  }
}

class HourlyWeather {
  final int timestamp;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;

  HourlyWeather({
    required this.timestamp,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      timestamp: json['dt'],
      temperature: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      humidity: json['humidity'],
      windSpeed: (json['wind_speed'] as num).toDouble(),
      weatherMain: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': timestamp,
      'temp': temperature,
      'feels_like': feelsLike,
      'humidity': humidity,
      'wind_speed': windSpeed,
      'weather': [
        {
          'main': weatherMain,
          'description': weatherDescription,
          'icon': weatherIcon,
        }
      ],
    };
  }
}

class DailyWeather {
  final int timestamp;
  final double tempDay;
  final double tempMin;
  final double tempMax;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;

  DailyWeather({
    required this.timestamp,
    required this.tempDay,
    required this.tempMin,
    required this.tempMax,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      timestamp: json['dt'],
      tempDay: (json['temp']['day'] as num).toDouble(),
      tempMin: (json['temp']['min'] as num).toDouble(),
      tempMax: (json['temp']['max'] as num).toDouble(),
      weatherMain: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': timestamp,
      'temp': {
        'day': tempDay,
        'min': tempMin,
        'max': tempMax,
      },
      'weather': [
        {
          'main': weatherMain,
          'description': weatherDescription,
          'icon': weatherIcon,
        }
      ],
    };
  }
}
