import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studio_luiza_web/pages/home_page.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  deslogarUsuario() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const HomePage())),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleSpacing: 0,
        title: const Text('Studio Luiza',
            style: TextStyle(fontSize: 20, letterSpacing: 6)),
        actions: [
          IconButton(
              onPressed: () {
                deslogarUsuario();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Adicione a lógica para lidar com o clique no primeiro item do Drawer aqui.
                Navigator.pop(context); // Fecha o Drawer
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Adicione a lógica para lidar com o clique no segundo item do Drawer aqui.
                Navigator.pop(context); // Fecha o Drawer
              },
            ),
            // Adicione mais itens do Drawer conforme necessário
          ],
        ),
      ),
      body: Column(
        children: [
          // Conteúdo principal aqui
        ],
      ),
    );
  }
}

class TextoWidget extends StatelessWidget {
  const TextoWidget(
      {super.key,
      required this.texto,
      required this.size,
      required this.fontFamily,
      required this.letterSpacing});

  final String texto;
  final double size;
  final String fontFamily;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
          color: const Color(0xFF4E4E4E),
          fontSize: size,
          fontFamily: fontFamily,
          letterSpacing: letterSpacing),
    );
  }
}
