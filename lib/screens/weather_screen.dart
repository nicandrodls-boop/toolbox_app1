import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _service = WeatherService();

  WeatherModel? weather;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    cargarClima();
  }

  Future<void> cargarClima() async {
    try {
      final resultado = await _service.getWeather();

      setState(() {
        weather = resultado;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = "No se pudo obtener el clima.";
        loading = false;
      });
    }
  }

  IconData obtenerIcono(int code) {
    if (code == 0) {
      return Icons.wb_sunny;
    } else if (code <= 3) {
      return Icons.cloud;
    } else if (code <= 67) {
      return Icons.grain;
    } else {
      return Icons.thunderstorm;
    }
  }

  String obtenerEstado(int code) {
    if (code == 0) {
      return "Despejado";
    } else if (code <= 3) {
      return "Parcialmente nublado";
    } else if (code <= 67) {
      return "Lluvias";
    } else {
      return "Tormenta";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clima en República Dominicana"),
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : error != null
            ? Text(error!)
            : Card(
          elevation: 6,
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Icon(
                  obtenerIcono(weather!.weatherCode),
                  size: 90,
                  color: Colors.orange,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Santo Domingo, RD",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "${weather!.temperature} °C",
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  obtenerEstado(weather!.weatherCode),
                  style: const TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 15),

                Text(
                  "Viento: ${weather!.windSpeed} km/h",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}