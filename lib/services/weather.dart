import 'package:myclima/services/location.dart';
import 'package:myclima/services/networking.dart';
import 'package:geolocator/geolocator.dart';

const apiKey = '26f480ce1b454dbfc1911b2a9738fc48';
const weatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  late var weatherData;

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$weatherUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    LocationPermission permission = await Geolocator.requestPermission();
    await location.getCurrentLocation();
    print("Permission is $permission");
    print("Latitiude is: ${location.latitude}");
    print("Longitude is: ${location.longitude}");
    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$weatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
