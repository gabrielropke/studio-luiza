import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studio_luiza_web/pages/thankyou_page.dart';

class ResumePage extends StatefulWidget {
  final String servico;
  final String subServico;
  final TimeOfDay horario;
  final String nome;
  final String email;
  final String telefone;
  const ResumePage(
      {super.key,
      required this.servico,
      required this.horario,
      required this.nome,
      required this.email,
      required this.telefone,
      required this.subServico});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  late String servico;
  late String subServico;
  late TimeOfDay horario;
  late String nome;
  late String email;
  late String telefone;

  int cilios = 3;
  int maquiagem = 1;
  double sobrancelha = 0.3;
  int manutencao = 2;

  formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final time = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = DateFormat.Hm().format(time);
    return formattedTime;
  }

  Future<void> enviarDadosFirebase() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection('agendamentos').add({
      'servico': servico,
      'subservico': subServico,
      'horario': formatTimeOfDay(horario),
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'status': 'pendente',
    });

    String novoId = documentReference.id;

    await documentReference.update({'agendamentoid': novoId});
  }

  void sucessAlert() {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Prontinho!!!',
            desc:
                'Sua solicitação foi enviada para Luiza, em até 24hrs ela entrará em contato!',
            btnOkOnPress: () {
              enviarDadosFirebase();
            },
            btnOkText: 'Ok')
        .show();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    servico = widget.servico;
    horario = widget.horario;
    nome = widget.nome;
    email = widget.email;
    telefone = widget.telefone;
    subServico = widget.subServico;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text(
              'Resumo',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22,
                  color: Colors.black87),
            ),
            const SizedBox(height: 15),
            container_widget(
              titulo: 'Atendimento',
              subtitulo: '$servico - $subServico',
              icone: const Icon(Icons.apps_rounded),
            ),
            const SizedBox(height: 15),
            container_widget(
              titulo: 'Horário',
              subtitulo: formatTimeOfDay(horario),
              icone: const Icon(Icons.access_time_rounded),
            ),
            const SizedBox(height: 15),
            const container_widget(
              titulo: 'Endereço',
              subtitulo:
                  'R. Bom Jesus, 157 - Barro Preto,\nMariana - MG, 35420-000',
              icone: Icon(Icons.share_location_rounded),
            ),
            const SizedBox(height: 15),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      servico == 'Cílios' && subServico == 'Volume Brasileiro'
                          ? 'R\$100,00'
                          : servico == 'Cílios' &&
                                  subServico == 'Volume Europeu'
                              ? 'R\$110,00'
                              : servico == 'Cílios' &&
                                      subServico == 'Volume Egípcio'
                                  ? 'R\$120,00'
                                  : servico == 'Cílios' &&
                                          subServico == 'Volume Luxo'
                                      ? 'R\$130,00'
                                      : servico == 'Cílios' &&
                                              subServico == 'Volume Brasileiro'
                                          ? 'R\$140,00'
                                          : 'Consultar valor',
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 25,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Pagamento no local e somente após o atendimento!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            BotaoWidget(
              texto: 'Enviar Solicitação',
              funcao: () {
                sucessAlert();
              },
              corBotao: const Color.fromARGB(255, 238, 163, 185),
              corTexto: Colors.white,
            ),
            const SizedBox(height: 10),
            BotaoWidget(
              texto: 'Editar pedido',
              funcao: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThankyouPage()));
              },
              corBotao: Colors.white,
              corTexto: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class container_widget extends StatelessWidget {
  const container_widget(
      {super.key,
      required this.titulo,
      required this.subtitulo,
      required this.icone});

  final Widget icone;
  final String titulo;
  final String subtitulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icone,
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 19,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitulo,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black45),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BotaoWidget extends StatelessWidget {
  const BotaoWidget(
      {super.key,
      required this.texto,
      required this.funcao,
      required this.corBotao,
      required this.corTexto});

  final String texto;
  final Function funcao;
  final Color corBotao;
  final Color corTexto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            funcao();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: corBotao,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13))),
          child: Center(
            child: Text(
              texto,
              style: TextStyle(
                  color: corTexto, fontSize: 18, fontFamily: 'Montserrat'),
            ),
          ),
        ));
  }
}
