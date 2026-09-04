class WeatherModel {
  final double temp;
  final double feelsLike;

  WeatherModel({required this.temp, required this.feelsLike});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
    );
  }
}
