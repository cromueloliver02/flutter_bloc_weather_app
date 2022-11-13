import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String name;
  final String description;
  final String country;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final DateTime lastUpdated;

  const Weather({
    required this.name,
    required this.description,
    required this.country,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.lastUpdated,
  });

  factory Weather.initial() {
    return Weather(
      name: '',
      description: '',
      country: '',
      icon: '',
      temp: 100.0,
      tempMin: 100.0,
      tempMax: 100.0,
      lastUpdated: DateTime(1970),
    );
  }

  @override
  List<Object> get props {
    return [
      name,
      description,
      country,
      icon,
      temp,
      tempMin,
      tempMax,
      lastUpdated,
    ];
  }

  @override
  String toString() {
    return 'Weather(name: $name, description: $description, country: $country, icon: $icon, temp: $temp, tempMin: $tempMin, tempMax: $tempMax, lastUpdated: $lastUpdated)';
  }

  Weather copyWith({
    String? name,
    String? description,
    String? country,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    DateTime? lastUpdated,
  }) {
    return Weather(
      name: name ?? this.name,
      description: description ?? this.description,
      country: country ?? this.country,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'country': country});
    result.addAll({'icon': icon});
    result.addAll({'temp': temp});
    result.addAll({'tempMin': tempMin});
    result.addAll({'tempMax': tempMax});
    result.addAll({'lastUpdated': lastUpdated.millisecondsSinceEpoch});

    return result;
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];

    return Weather(
      name: '',
      country: '',
      description: weather['description'] ?? '',
      icon: weather['icon'] ?? '',
      temp: main['temp']?.toDouble() ?? 0.0,
      tempMin: main['temp_min']?.toDouble() ?? 0.0,
      tempMax: main['temp_max']?.toDouble() ?? 0.0,
      lastUpdated: DateTime.now(),
    );
  }
}
