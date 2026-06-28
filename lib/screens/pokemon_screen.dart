import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/pokemon_model.dart';
import '../services/pokemon_service.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {

  final TextEditingController controller = TextEditingController();
  final PokemonService service = PokemonService();
  final AudioPlayer player = AudioPlayer();

  PokemonModel? pokemon;
  bool loading = false;
  String? error;

  Future<void> buscarPokemon() async {

    if (controller.text.trim().isEmpty) return;

    setState(() {
      loading = true;
      error = null;
      pokemon = null;
    });

    try {

      final resultado = await service.getPokemon(controller.text.trim());

      setState(() {
        pokemon = resultado;
      });

    } catch (e) {

      setState(() {
        error = "Pokémon no encontrado";
      });

    }

    setState(() {
      loading = false;
    });

  }

  Future<void> reproducirSonido() async {

    if (pokemon == null) return;

    await player.stop();

    await player.play(
      UrlSource(pokemon!.cry),
    );

  }

  @override
  void dispose() {
    player.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Pokémon"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Nombre del Pokémon",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: buscarPokemon,
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

            if (pokemon != null)

              Expanded(
                child: ListView(

                  children: [

                    Card(

                      elevation: 5,

                      child: Padding(

                        padding: const EdgeInsets.all(20),

                        child: Column(

                          children: [

                            Image.network(
                              pokemon!.image,
                              height: 180,
                            ),

                            const SizedBox(height: 20),

                            Text(
                              pokemon!.name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 15),

                            Text(
                              "Experiencia Base: ${pokemon!.baseExperience}",
                              style: const TextStyle(fontSize: 18),
                            ),

                            const SizedBox(height: 20),

                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Habilidades",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            ...pokemon!.abilities.map(
                                  (ability) => ListTile(
                                leading: const Icon(Icons.flash_on),
                                title: Text(ability),
                              ),
                            ),

                            const SizedBox(height: 15),

                            ElevatedButton.icon(

                              onPressed: reproducirSonido,

                              icon: const Icon(Icons.volume_up),

                              label: const Text("Escuchar sonido"),

                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}