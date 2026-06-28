import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/wordpress_model.dart';
import '../services/wordpress_service.dart';

class WordpressScreen extends StatefulWidget {
  const WordpressScreen({super.key});

  @override
  State<WordpressScreen> createState() => _WordpressScreenState();
}

class _WordpressScreenState extends State<WordpressScreen> {
  final WordpressService service = WordpressService();

  List<WordpressModel> posts = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    cargarNoticias();
  }

  Future<void> cargarNoticias() async {
    try {
      final resultado = await service.getPosts();

      setState(() {
        posts = resultado;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = "No se pudieron cargar las noticias.";
        loading = false;
      });
    }
  }

  String limpiarHtml(String texto) {
    return texto
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&#8230;', '...')
        .replaceAll('&nbsp;', ' ');
  }

  Future<void> abrirNoticia(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Noticias WordPress"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text(error!))
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Image.network(
            "https://s.w.org/style/images/about/WordPress-logotype-standard.png",
            height: 90,
          ),

          const SizedBox(height: 25),

          ...posts.map(
                (post) => Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      limpiarHtml(post.title),
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      limpiarHtml(post.excerpt),
                    ),

                    const SizedBox(height: 12),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          abrirNoticia(post.link);
                        },
                        child: const Text("Visitar noticia"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}