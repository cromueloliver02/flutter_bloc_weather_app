import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final String country;
  final double lon;
  final double lat;

  const DirectGeocoding({
    required this.name,
    required this.country,
    required this.lon,
    required this.lat,
  });

  @override
  List<Object> get props => [name, country, lon, lat];

  @override
  String toString() {
    return 'DirectGeocoding(name: $name, country: $country, lon: $lon, lat: $lat)';
  }

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final map = json[0];

    return DirectGeocoding(
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      lon: map['lon']?.toDouble() ?? 0.0,
      lat: map['lat']?.toDouble() ?? 0.0,
    );
  }
}
