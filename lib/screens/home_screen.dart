import 'package:flutter/material.dart';
import 'gender_screen.dart';
import 'age_screen.dart';
import 'university_screen.dart';
import 'weather_screen.dart';
import 'pokemon_screen.dart';
import 'wordpress_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.95, end: 1),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => screen),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.9),
                    color.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(3, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 42, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.deepPurple],
            ),
          ),
        ),
        title: const Text(
          '🧰 Caja de Herramientas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),

      // 🔥 SOLUCIÓN FINAL SIN OVERFLOW
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [Colors.deepPurple, Colors.blueAccent],
                      ),
                    ),
                    child: const Text(
                      "Explora tus herramientas digitales",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate(
                [
                  buildTile(context: context, title: "Género", icon: Icons.person, color: Colors.pink, screen: const GenderScreen()),
                  buildTile(context: context, title: "Edad", icon: Icons.cake, color: Colors.orange, screen: const AgeScreen()),
                  buildTile(context: context, title: "Universidades", icon: Icons.school, color: Colors.blue, screen: const UniversityScreen()),
                  buildTile(context: context, title: "Clima RD", icon: Icons.cloud, color: Colors.lightBlue, screen: const WeatherScreen()),
                  buildTile(context: context, title: "Pokémon", icon: Icons.catching_pokemon, color: Colors.red, screen: const PokemonScreen()),
                  buildTile(context: context, title: "Noticias", icon: Icons.article, color: Colors.green, screen: const WordpressScreen()),
                  buildTile(context: context, title: "Acerca de", icon: Icons.info, color: Colors.deepPurple, screen: const AboutScreen()),
                ],
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}