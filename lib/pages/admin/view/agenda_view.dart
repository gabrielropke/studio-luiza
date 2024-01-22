import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studio_luiza_web/pages/admin/pages/agenda.dart';
import 'package:studio_luiza_web/pages/admin/pages/financeiro.dart';
import 'package:studio_luiza_web/pages/admin/view/home_admin.dart';
import 'package:studio_luiza_web/pages/home_page.dart';

class AgendaView extends StatefulWidget {
  const AgendaView({super.key});

  @override
  State<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView> {
  FirebaseAuth auth = FirebaseAuth.instance;

  List<String> agendamentosId = [];

  deslogarUsuario() {
    auth.signOut();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const HomePage())),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEFEFEF),
        appBar: AppBar(
          elevation: 0,
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
              DrawerHeader(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.asset(
                        'assets/images/luiza_foto.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextoWidget(
                      texto: 'Luiza Franco',
                      letterSpacing: 2,
                      size: 16,
                      fontFamily: ''),
                  const SizedBox(height: 3),
                  const TextoWidget(
                      texto: 'Studio Luiza',
                      letterSpacing: 2,
                      size: 20,
                      fontFamily: 'Montserrat'),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeAdmin()));
                      },
                      leading: const Icon(
                        Icons.mark_email_unread_outlined,
                        size: 28,
                        color: Colors.black54,
                      ),
                      title: const TextoWidget(
                          texto: 'PEDIDOS',
                          letterSpacing: 3,
                          size: 18,
                          fontFamily: 'Montserrat'),
                    ),
                    const Divider(height: 20),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgendaView()));
                      },
                      leading: const Icon(
                        Icons.access_alarms_rounded,
                        size: 28,
                        color: Colors.black54,
                      ),
                      title: const TextoWidget(
                          texto: 'AGENDA',
                          letterSpacing: 3,
                          size: 18,
                          fontFamily: 'Montserrat'),
                    ),
                    const Divider(height: 20),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FinanceiroPage()));
                      },
                      leading: const Icon(
                        Icons.credit_card,
                        size: 28,
                        color: Colors.black54,
                      ),
                      title: const TextoWidget(
                          texto: 'FINANCEIRO',
                          letterSpacing: 3,
                          size: 18,
                          fontFamily: 'Montserrat'),
                    ),
                    const Divider(height: 20),
                  ],
                ),
              ),
              // Adicione mais itens do Drawer conforme necessário
            ],
          ),
        ),
        body: AgendaPage());
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
