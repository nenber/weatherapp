class City {
  final String name;
  final Map<String, String> localNames;
  final double lat;
  final double lon;
  final String country;
  final String? state;

  City({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
  });

  /// Factory method to create a `City` object from a JSON map
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] as String,
      localNames: Map<String, String>.from(json['local_names'] ?? {}),
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] as String,
      state: json['state'] as String?,
    );
  }

  /// Method to convert a `City` object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'local_names': localNames,
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
    };
  }
}
