import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studio_luiza_web/pages/admin/home_admin.dart';
import 'package:studio_luiza_web/pages/admin/login_page.dart';
import 'package:studio_luiza_web/pages/agendar_pageone.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void launchWhatsapp(
    String phone,
    String message,
  ) async {
    final url = 'https://wa.me/$phone?text=$message';

    await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  void launchInstagram() async {
    const url = 'https://www.instagram.com/luizafranco_studio/';

    await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  Future verificaUsuarioLogado() async {
    // com //#coment o login não acontece
    // sem //#coment o login acontece

    FirebaseAuth auth = FirebaseAuth.instance;
    // auth.signOut();

    User? usuarioLogado = auth.currentUser;
    if (usuarioLogado != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeAdmin())));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificaUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(
                Icons.assignment_ind_outlined,
                color: Colors.white,
              )),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child: Image.asset(
                        'assets/images/homepage_imagem.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextoWidget(
                      texto: 'STUDIO LUIZA',
                      letterSpacing: 5,
                      textoSize: 30,
                      fonte: 'Montserrat'),
                  const TextoWidget(
                    texto: 'Renovando a sua autoestima!',
                    letterSpacing: 10,
                    textoSize: 18,
                    fonte: '',
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AgendarPageOne()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 238, 163, 185),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32))),
                        child: const Center(
                          child: Text(
                            'Agendar horário',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      )),
                  const SizedBox(height: 30),
                  const TextoWidget(
                      texto: 'Outros\ncontatos',
                      letterSpacing: 3,
                      textoSize: 16,
                      fonte: ''),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchWhatsapp(
                              '31997798995', 'Testando automação de texto');
                        },
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            'assets/images/icone_wpp.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          launchInstagram();
                        },
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            'assets/images/icone_insta.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextoWidget extends StatelessWidget {
  const TextoWidget(
      {super.key,
      required this.texto,
      required this.letterSpacing,
      required this.textoSize,
      required this.fonte});

  final String texto;
  final double letterSpacing;
  final double textoSize;
  final String fonte;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: textoSize,
            fontFamily: fonte,
            letterSpacing: letterSpacing),
      ),
    );
  }
}
