import 'package:flutter/material.dart';
import 'package:studio_luiza_web/pages/resume_page.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/images_service/images_cilios_brasileiro.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/images_service/images_cilios_europeu.dart';
import 'package:studio_luiza_web/widgets/textfield_widget.dart';

class cilios_page extends StatefulWidget {
  final String servico;
  final TimeOfDay horario;
  final String nome;
  final String email;
  final String telefone;
  const cilios_page(
      {super.key,
      required this.servico,
      required this.horario,
      required this.nome,
      required this.email,
      required this.telefone});

  @override
  State<cilios_page> createState() => _cilios_pageState();
}

class _cilios_pageState extends State<cilios_page> {
  final TextEditingController controllerOBS = TextEditingController();

  late String servico;
  late TimeOfDay horario;
  late String nome;
  late String email;
  late String telefone;

  String selectedContainer = '';

  bool isMobilesmaller(BuildContext context) =>
      MediaQuery.of(context).size.width <= 415;
  bool isMobilebigger(BuildContext context) =>
      MediaQuery.of(context).size.width > 415;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    servico = widget.servico;
    horario = widget.horario;
    nome = widget.nome;
    email = widget.email;
    telefone = widget.telefone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Qual cílios iremos fazer?',
                  style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 20),
              if (isMobilebigger(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildContainer(texto: 'Volume Brasileiro', width: 180),
                    const SizedBox(width: 15),
                    buildContainer(texto: 'Volume Luxo', width: 180),
                  ],
                ),
              if (isMobilesmaller(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildContainer(texto: 'Volume Brasileiro', width: 150),
                    const SizedBox(width: 15),
                    buildContainer(texto: 'Volume Luxo', width: 150),
                  ],
                ),
              const SizedBox(height: 15),
              if (isMobilebigger(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildContainer(texto: 'Volume Europeu', width: 180),
                    const SizedBox(width: 15),
                    buildContainer(texto: 'Volume Definir', width: 180),
                  ],
                ),
              if (isMobilesmaller(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildContainer(texto: 'Volume Europeu', width: 150),
                    const SizedBox(width: 15),
                    buildContainer(texto: 'Volume Definir', width: 150),
                  ],
                ),
              const SizedBox(height: 15),
              if (isMobilebigger(context))
                Align(
                    alignment: Alignment.centerLeft,
                    child: buildContainer(texto: 'Volume Egípcio', width: 180)),
              if (isMobilesmaller(context))
                Align(
                    alignment: Alignment.centerLeft,
                    child: buildContainer(texto: 'Volume Egípcio', width: 150)),
              const SizedBox(height: 30),
              if (selectedContainer == 'Volume Brasileiro')
                const ImagesCiliosBrasileiro(),
              if (selectedContainer == 'Volume Europeu')
                const ImagesCiliosEuropeu(),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Alguma observação?',
                  style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              textfieldwidget(
                  controller: controllerOBS,
                  maxLines: 1,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  hintText: 'Digite aqui...'),
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Informações',
                  style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F2),
                    borderRadius: BorderRadius.circular(16)),
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text(
                          '• O pagamento é feito no local e somente após o atendimento;\n\n• Temos 24 horas para aprovar o seu atendimento, mas não se preocupe, os horários mesmo que ainda não aprovados não podem ser solicitados por 2 pessoas ao mesmo tempo!',
                          style: TextStyle(
                            fontSize: 18,
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResumePage(
                                  servico: servico,
                                  horario: horario,
                                  nome: nome,
                                  email: email,
                                  telefone: telefone,
                                  subServico: selectedContainer)));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 238, 163, 185),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13))),
                    child: const Center(
                      child: Text(
                        'Ver resumo',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer({required String texto, required double width}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedContainer = texto;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedContainer == texto ? Colors.white : Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(32),
          color: selectedContainer == texto
              ? const Color.fromARGB(255, 255, 235, 241)
              : Colors.white,
        ),
        child: Center(
          child: Text(
            texto,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontFamily: 'Montserrat'),
          ),
        ),
      ),
    );
  }
}
