import 'package:flutter/material.dart';

import '../models/gender_model.dart';
import '../services/gender_service.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final TextEditingController _controller = TextEditingController();
  final GenderService _service = GenderService();

  GenderModel? _gender;
  bool _loading = false;
  String? _error;

  Future<void> _buscarGenero() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
      _gender = null;
    });

    try {
      final resultado = await _service.getGender(_controller.text.trim());

      setState(() {
        _gender = resultado;
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

  Color _colorGenero() {
    if (_gender?.gender == "male") {
      return Colors.blue.shade200;
    } else if (_gender?.gender == "female") {
      return Colors.pink.shade200;
    }
    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorGenero(),
      appBar: AppBar(
        title: const Text("Predicción de Género"),
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
                onPressed: _buscarGenero,
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

            if (_gender != null)
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [

                      Text(
                        "Género:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        _gender!.gender == "male"
                            ? "Masculino"
                            : _gender!.gender == "female"
                            ? "Femenino"
                            : "Desconocido",
                        style: const TextStyle(fontSize: 26),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Probabilidad: ${((_gender!.probability ?? 0) * 100).toStringAsFixed(1)}%",
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