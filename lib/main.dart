import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String titulo = "Bienvenido a mi pagina";

  void cambiarTitulo() {
    setState(() {
      titulo = (titulo == "Bienvenido a mi pagina")
          ? "¡Título cambiado!"
          : "Bienvenido a mi pagina";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Título actualizado")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            const Text(
              "Jolmer Alexander Viedma Agudelo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  'https://cdn-assets-eu.frontify.com/s3/frontify-enterprise-files-eu/eyJwYXRoIjoic3VwZXJjZWxsXC9maWxlXC9xc0Jpb0xZdlBiQjhXTG5BZVlhdi5wbmcifQ:supercell:HWByBct6jbqZw_IrEeKpI1WbGVT1dqqQaNp_WUtdq84?width=2400',
                  width: 100,
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: cambiarTitulo,
              child: const Text("Cambiar título"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [

                  InfoCard(
                    imagen: 'assets/primo.png',
                    nombre: "EL PRIMO",
                  ),

                  InfoCard(
                    imagen: 'assets/bull.png',
                    nombre: "ROSA",
                  ),

                  InfoCard(
                    imagen: 'assets/rosa.png',
                    nombre: "ROSA",
                  ),

                  InfoCard(
                    imagen: 'assets/darryl.png',
                    nombre: "DARRYL",
                  ),

                  InfoCard(
                    imagen: 'assets/jacky.png',
                    nombre: "JACKY",
                  ),

                  InfoCard(
                    imagen: 'assets/frank.png',
                    nombre: "FRANK",
                  ),

                  InfoCard(
                    imagen: 'assets/bibi.png',
                    nombre: "BIBI",
                  ),

                  InfoCard(
                    imagen: 'assets/ash.png',
                    nombre: "ASH",
                  ),

                  InfoCard(
                    imagen: 'assets/sam.png',
                    nombre: "SAM",
                  ),

                  InfoCard(
                    imagen: 'assets/hank.png',
                    nombre: "HANK",
                  ),

                  InfoCard(
                    imagen: 'assets/trunk.png',
                    nombre: "TRUNK",
                  ),

                  InfoCard(
                    imagen: 'assets/buzz.png',
                    nombre: "BUZZ",
                  ),

                  InfoCard(
                    imagen: 'assets/buster.png',
                    nombre: "BUSTER",
                  ),

                  InfoCard(
                    imagen: 'assets/doug.png',
                    nombre: "DOUG",
                  ),

                  InfoCard(
                    imagen: 'assets/chuck.png',
                    nombre: "CHUCK",
                  ),

                  InfoCard(
                    imagen: 'assets/ollie.png',
                    nombre: "OLLIE",
                  ),

                  InfoCard(
                    imagen: 'assets/meg.png',
                    nombre: "MEG",
                  ),

                  InfoCard(
                    imagen: 'assets/draco.png',
                    nombre: "DRACO",
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

class InfoCard extends StatelessWidget {

  final String imagen;
  final String nombre;

  const InfoCard({
    super.key,
    required this.imagen,
    required this.nombre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🖼️ Imagen
          Center(
            child: Image.asset(
              imagen,
              height: 150,
              width: 240,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            nombre,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );
  }
}