import 'package:flutter/material.dart';

import '../models/age_model.dart';
import '../services/age_service.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _controller = TextEditingController();
  final AgeService _service = AgeService();

  AgeModel? _age;
  bool _loading = false;
  String? _error;

  Future<void> _buscarEdad() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
      _age = null;
    });

    try {
      final resultado = await _service.getAge(_controller.text.trim());

      setState(() {
        _age = resultado;
      });
    } catch (e) {
      setState(() {
        _error = "No se pudo obtener la información.";
      });
    }

    setState(() {
      _loading = false;
    });
  }

  String _categoriaEdad() {
    if (_age?.age == null) return "Desconocido";

    if (_age!.age! < 18) {
      return "Joven";
    } else if (_age!.age! < 60) {
      return "Adulto";
    } else {
      return "Anciano";
    }
  }

  String _imagenEdad() {
    if (_age?.age == null) return "";

    if (_age!.age! < 18) {
      return "assets/images/young.png";
    } else if (_age!.age! < 60) {
      return "assets/images/adult.png";
    } else {
      return "assets/images/old.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Predicción de Edad"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _buscarEdad,
                child: const Text("Predecir"),
              ),
            ),

            const SizedBox(height: 30),

            if (_loading)
              const CircularProgressIndicator(),

            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),

            if (_age != null)
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [

                      Image.asset(
                        _imagenEdad(),
                        height: 150,
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "Edad estimada: ${_age!.age ?? 0} años",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        _categoriaEdad(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}