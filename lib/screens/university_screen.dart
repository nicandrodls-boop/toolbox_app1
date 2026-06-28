import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/university_model.dart';
import '../services/university_service.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({super.key});

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  final TextEditingController _controller = TextEditingController();
  final UniversityService _service = UniversityService();

  List<UniversityModel> universities = [];
  bool loading = false;
  String? error;

  Future<void> buscarUniversidades() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      loading = true;
      error = null;
      universities = [];
    });

    try {
      final resultado =
      await _service.getUniversities(_controller.text.trim());

      setState(() {
        universities = resultado;
      });
    } catch (e) {
      setState(() {
        error = "No se pudieron obtener las universidades.";
      });
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> abrirPagina(String url) async {
    print(url);

    final Uri uri = Uri.parse(url);

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Universidades"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "País en inglés",
                hintText: "Dominican Republic",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: buscarUniversidades,
                child: const Text("Buscar"),
              ),
            ),

            const SizedBox(height: 20),

            if (loading)
              const CircularProgressIndicator(),

            if (error != null)
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),

            Expanded(
              child: ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  final uni = universities[index];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            uni.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Dominio: ${uni.domains.isNotEmpty ? uni.domains.first : "No disponible"}",
                          ),

                          const SizedBox(height: 8),

                          TextButton(
                            onPressed: () {
                              if (uni.webPages.isNotEmpty) {
                                abrirPagina(uni.webPages.first);
                              }
                            },
                            child: const Text("Visitar página web"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}