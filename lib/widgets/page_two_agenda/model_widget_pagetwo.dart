import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:studio_luiza_web/pages/resume_page.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/endereco_cadastro.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/images_service/images_cilios_brasileiro.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/images_service/images_cilios_europeu.dart';
import 'package:studio_luiza_web/widgets/textfield_widget.dart';

class ModelWidgetPageTwo extends StatefulWidget {
  final String servico;
  final TimeOfDay horario;
  final DateTime data;
  final String nome;
  final String email;
  final String telefone;
  const ModelWidgetPageTwo(
      {super.key,
      required this.servico,
      required this.horario,
      required this.nome,
      required this.email,
      required this.telefone,
      required this.data});

  @override
  State<ModelWidgetPageTwo> createState() => _ModelWidgetPageTwoState();
}

class _ModelWidgetPageTwoState extends State<ModelWidgetPageTwo> {
  final TextEditingController controllerOBS = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController compController = TextEditingController();

  late String servico;
  late TimeOfDay horario;
  late String nome;
  late String email;
  late String telefone;
  late DateTime data;

  String selectedContainer = '';

  bool isMobilesmaller(BuildContext context) =>
      MediaQuery.of(context).size.width <= 415;
  bool isMobilebigger(BuildContext context) =>
      MediaQuery.of(context).size.width > 415;

  void errorAlert(String message) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Atenção',
            desc: message,
            btnOkOnPress: () {},
            btnOkText: 'Voltar')
        .show();
  }

  void errorAlertEnd() {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Atenção',
            desc: 'Preencha todos os dados',
            btnOkOnPress: () {},
            btnOkText: 'Voltar')
        .show();
  }

  // FINALIZAR VALIDAÇÃO COM TODOS MÉTODOS

  void validarDados() {
    if (selectedContainer == '') {
      errorAlert('Você precisa escolher um serviço antes de continuar...');
    } else if (selectedContainer == 'Em domicílio' &&
        cepController.text.isEmpty) {
      errorAlertEnd();
    } else if (selectedContainer == 'Em domicílio' &&
        ufController.text.isEmpty) {
      errorAlertEnd();
    } else if (selectedContainer == 'Em domicílio' &&
        cidadeController.text.isEmpty) {
      errorAlertEnd();
    } else if (selectedContainer == 'Em domicílio' &&
        bairroController.text.isEmpty) {
      errorAlertEnd();
    } else if (selectedContainer == 'Em domicílio' &&
        ruaController.text.isEmpty) {
      errorAlertEnd();
    } else if (selectedContainer == 'Em domicílio' &&
        numeroController.text.isEmpty) {
      errorAlertEnd();
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResumePage(
                    servico: servico,
                    horario: horario,
                    nome: nome,
                    email: email,
                    telefone: telefone,
                    subServico: selectedContainer,
                    ruaController: ruaController.text,
                    numeroController: numeroController.text,
                    ufController: ufController.text,
                    cidadeController: cidadeController.text,
                    cepController: cepController.text,
                    bairroController: bairroController.text,
                    compController: compController.text,
                    data: data,
                    observacao: controllerOBS.text,
                  )));
    }
  }

  @override
  void initState() {
    super.initState();
    servico = widget.servico;
    horario = widget.horario;
    nome = widget.nome;
    email = widget.email;
    telefone = widget.telefone;
    data = widget.data;
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
              const SizedBox(height: 10),
              ServiceText(servico: servico),
              const SizedBox(height: 20),
              if (servico == 'Cílios') buildCilios(context),
              if (servico == 'Manutenção') buildCilios(context),
              if (servico == 'Maquiagem') buildMaquiagem(context),
              if (selectedContainer == 'Volume Brasileiro')
                const ImagesCiliosBrasileiro(),
              if (selectedContainer == 'Volume Europeu')
                const ImagesCiliosEuropeu(),
              if (selectedContainer == 'Em domicílio')
                CadastroEndereco(
                    ruaController: ruaController,
                    numeroController: numeroController,
                    ufController: ufController,
                    cidadeController: cidadeController,
                    cepController: cepController,
                    bairroController: bairroController,
                    compController: compController),
              const TextoWidget(texto: 'Alguma observação?'),
              const SizedBox(height: 10),
              textfieldwidget(
                  controller: controllerOBS,
                  maxLines: 1,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  hintText: 'Digite aqui...'),
              const SizedBox(height: 30),
              const TextoWidget(texto: 'Informações'),
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
                      validarDados();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 114, 156),
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

  Widget buildMaquiagem(BuildContext context) {
    return Column(
      children: [
        if (isMobilebigger(context))
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildContainer(texto: 'Studio Luiza', width: 180),
              const SizedBox(width: 15),
              buildContainer(texto: 'Em domicílio', width: 180),
            ],
          ),
        if (isMobilesmaller(context))
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildContainer(texto: 'Studio Luiza', width: 150),
              const SizedBox(width: 15),
              buildContainer(texto: 'Em domicílio', width: 150),
            ],
          ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget buildCilios(BuildContext context) {
    return Column(
      children: [
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
      ],
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

class TextoWidget extends StatelessWidget {
  const TextoWidget({super.key, required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
      ),
    );
  }
}

class ServiceText extends StatelessWidget {
  const ServiceText({super.key, required this.servico});

  final String servico;

  @override
  Widget build(BuildContext context) {
    return Text(
        servico == 'Maquiagem'
            ? 'Onde você prefere ser maquiada?'
            : servico == 'Cílios'
                ? 'Qual cílios iremos fazer?'
                : servico == 'Sobrancelha'
                    ? 'Qual sobrancelha iremos fazer'
                    : servico == 'Manutenção'
                        ? 'Qual manutenção iremos fazer?'
                        : '',
        style: const TextStyle(fontSize: 16, fontFamily: 'Montserrat'));
  }
}
