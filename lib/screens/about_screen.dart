import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                const SizedBox(height: 10),

                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(
                    "assets/images/profile.jpeg",
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  " Nicandro De Los Santos",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                const ListTile(
                  leading: Icon(Icons.email),
                  title: Text("nicandrodls@gmail.com"),
                ),

                const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("+1 829-219-7676"),
                ),

                const Divider(),

                const SizedBox(height: 10),

                const Text(
                  "Soy estudiante de desarrollo de software con interés en el desarrollo de aplicaciones móviles utilizando Flutter. Me gusta crear aplicaciones organizadas, funcionales y con una interfaz agradable para el usuario.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.work),
                  label: const Text("Disponible para proyectos"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}