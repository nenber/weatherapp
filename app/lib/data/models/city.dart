// class City {
//   final String label;
//   final double score;
//   final String? housenumber; // Nullable
//   final String id;
//   final String type;
//   final String name;
//   final String postcode;
//   final String citycode;
//   final double x;
//   final double y;
//   final String city;
//   final String context;
//   final double importance;
//   final String? street; // Nullable
//   final List<double> coordinates;

//   City({
//     required this.label,
//     required this.score,
//     this.housenumber,
//     required this.id,
//     required this.type,
//     required this.name,
//     required this.postcode,
//     required this.citycode,
//     required this.x,
//     required this.y,
//     required this.city,
//     required this.context,
//     required this.importance,
//     this.street,
//     required this.coordinates,
//   });

//   /// Convertit un JSON en objet City
//   factory City.fromJson(Map<String, dynamic> json) {
//     return City(
//       label: json['properties']['label'] ?? 'Unknown', // Valeur par défaut
//       score: (json['properties']['score'] as num?)?.toDouble() ??
//           0.0, // Défaut à 0.0 si absent
//       housenumber: json['properties']['housenumber'], // Nullable
//       id: json['properties']['id'] ?? '',
//       type: json['properties']['type'] ?? 'unknown',
//       name: json['properties']['name'] ?? '',
//       postcode: json['properties']['postcode'] ?? '',
//       citycode: json['properties']['citycode'] ?? '',
//       x: (json['properties']['x'] as num?)?.toDouble() ?? 0.0,
//       y: (json['properties']['y'] as num?)?.toDouble() ?? 0.0,
//       city: json['properties']['city'] ?? '',
//       context: json['properties']['context'] ?? '',
//       importance: (json['properties']['importance'] as num?)?.toDouble() ?? 0.0,
//       street: json['properties']['street'], // Nullable
//       coordinates: (json['geometry']?['coordinates'] as List<dynamic>?)
//               ?.map((e) => (e as num).toDouble())
//               .toList() ??
//           [0.0, 0.0], // Valeur par défaut
//     );
//   }

//   /// Convertit un objet City en JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'label': label,
//       'score': score,
//       'housenumber': housenumber,
//       'id': id,
//       'type': type,
//       'name': name,
//       'postcode': postcode,
//       'citycode': citycode,
//       'x': x,
//       'y': y,
//       'city': city,
//       'context': context,
//       'importance': importance,
//       'street': street,
//       'geometry': {
//         'coordinates': coordinates,
//       },
//     };
//   }
// }
