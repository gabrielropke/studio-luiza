import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/model_widget_pagetwo.dart';
import 'package:studio_luiza_web/widgets/textfield_widget.dart';

class ModelWidget extends StatefulWidget {
  const ModelWidget({Key? key}) : super(key: key);

  @override
  _ModelWidgetState createState() => _ModelWidgetState();
}

class _ModelWidgetState extends State<ModelWidget> {
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerTelefone = TextEditingController();

  String selectedContainer = '';
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  int cilios = 3;
  int maquiagem = 1;
  double sobrancelha = 0.3;
  int manutencao = 2;
  DateTime selectedDate = DateTime.now();

  bool isMobilesmaller(BuildContext context) =>
      MediaQuery.of(context).size.width <= 415;
  bool isMobilebigger(BuildContext context) =>
      MediaQuery.of(context).size.width > 415;

  List<String> generateTimeList() {
    List<String> times = [];
    for (int hour = 7; hour <= 18; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        String formattedHour = hour.toString().padLeft(2, '0');
        String formattedMinute = minute.toString().padLeft(2, '0');
        times.add('$formattedHour:$formattedMinute');
      }
    }
    return times;
  }

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

  void validarDados() {
    if (selectedContainer == '') {
      errorAlert('Você precisa escolher um serviço antes de continuar...');
    } else if (controllerNome.text.isEmpty) {
      errorAlert('Precisamos saber o seu nome completo...');
    } else if (controllerEmail.text.isEmpty) {
      errorAlert('Precisamos saber o seu e-mail...');
    } else if (controllerTelefone.text.isEmpty) {
      errorAlert('Precisamos do seu telefone de contato...');
    }

    if (selectedContainer != '' &&
        controllerEmail.text.isNotEmpty &&
        controllerEmail.text.isNotEmpty &&
        controllerTelefone.text.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ModelWidgetPageTwo(
                    servico: selectedContainer,
                    horario: selectedTime,
                    nome: controllerNome.text,
                    email: controllerEmail.text,
                    telefone: controllerTelefone.text,
                    data: selectedDate,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            locale: 'pt_br',
            activeColor: const Color(0xffedadc0),
            onDateChange: (selectedDate) {
              setState(() {
                this.selectedDate = selectedDate;
              });
            },
          ),
          const SizedBox(height: 40),
          const Text(
            'Quem irá te atender?',
            style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
          ),
          const SizedBox(height: 10),
          Container(
            width: 140,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: const Color.fromARGB(255, 255, 235, 241)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 5),
                ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Image.asset(
                      'assets/images/luiza_foto.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Luiza',
                  style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'O que você procura?',
            style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
          ),
          const SizedBox(height: 10),
          if (isMobilebigger(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContainer(texto: 'Maquiagem', width: 180),
                const SizedBox(width: 15),
                buildContainer(texto: 'Sobrancelha', width: 180),
              ],
            ),
          if (isMobilesmaller(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContainer(texto: 'Maquiagem', width: 150),
                const SizedBox(width: 15),
                buildContainer(texto: 'Sobrancelha', width: 150),
              ],
            ),
          const SizedBox(height: 15),
          if (isMobilebigger(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContainer(texto: 'Cílios', width: 180),
                const SizedBox(width: 15),
                buildContainer(texto: 'Manutenção', width: 180),
              ],
            ),
          if (isMobilesmaller(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContainer(texto: 'Cílios', width: 150),
                const SizedBox(width: 15),
                buildContainer(texto: 'Manutenção', width: 150),
              ],
            ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Qual o melhor horário?',
                    style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded),
                      const SizedBox(width: 10),
                      Container(
                        width: 130,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 241, 241),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Text(
                              selectedTime.hour >= 12
                                  ? '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}'
                                  : selectedTime.format(context).replaceAll(
                                      RegExp(r'\s?[AaPp][Mm]$'), ''),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (String value) {
                                setState(() {
                                  selectedTime = TimeOfDay(
                                    hour: int.parse(value.split(':')[0]),
                                    minute: int.parse(value.split(':')[1]),
                                  );
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                // Criar itens para a lista suspensa de horários
                                List<String> times =
                                    generateTimeList(); // Função para gerar os horários
                                return times.map((String time) {
                                  return PopupMenuItem<String>(
                                    value: time,
                                    child: Text(time),
                                  );
                                }).toList();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'às',
                        style:
                            TextStyle(fontSize: 14, fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 130,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 241, 241),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedContainer == 'Maquiagem'
                                  ? TimeOfDay(
                                      hour:
                                          (selectedTime.hour + maquiagem) % 24,
                                      minute: selectedTime.minute,
                                    ).format(context).replaceAllMapped(
                                      RegExp(r'(\d+:\d+) ([AaPp][Mm])'),
                                      (match) {
                                        int hour = int.parse(
                                            match.group(1)!.split(":")[0]);
                                        if (match.group(2)?.toLowerCase() ==
                                                'pm' &&
                                            hour < 12) {
                                          hour += 12;
                                        } else if (match
                                                    .group(2)
                                                    ?.toLowerCase() ==
                                                'am' &&
                                            hour == 12) {
                                          hour = 0;
                                        }
                                        return '$hour:${match.group(1)!.split(":")[1]}';
                                      },
                                    )
                                  : selectedContainer == 'Cílios'
                                      ? TimeOfDay(
                                          hour:
                                              (selectedTime.hour + cilios) % 24,
                                          minute: selectedTime.minute,
                                        ).format(context).replaceAllMapped(
                                          RegExp(r'(\d+:\d+) ([AaPp][Mm])'),
                                          (match) {
                                            int hour = int.parse(
                                                match.group(1)!.split(":")[0]);
                                            if (match.group(2)?.toLowerCase() ==
                                                    'pm' &&
                                                hour < 12) {
                                              hour += 12;
                                            } else if (match
                                                        .group(2)
                                                        ?.toLowerCase() ==
                                                    'am' &&
                                                hour == 12) {
                                              hour = 0;
                                            }
                                            return '$hour:${match.group(1)!.split(":")[1]}';
                                          },
                                        )
                                      : selectedContainer == 'Manutenção'
                                          ? TimeOfDay(
                                              hour: (selectedTime.hour +
                                                      manutencao) %
                                                  24,
                                              minute: selectedTime.minute,
                                            ).format(context).replaceAllMapped(
                                              RegExp(r'(\d+:\d+) ([AaPp][Mm])'),
                                              (match) {
                                                int hour = int.parse(match
                                                    .group(1)!
                                                    .split(":")[0]);
                                                if (match
                                                            .group(2)
                                                            ?.toLowerCase() ==
                                                        'pm' &&
                                                    hour < 12) {
                                                  hour += 12;
                                                } else if (match
                                                            .group(2)
                                                            ?.toLowerCase() ==
                                                        'am' &&
                                                    hour == 12) {
                                                  hour = 0;
                                                }
                                                return '$hour:${match.group(1)!.split(":")[1]}';
                                              },
                                            )
                                          : selectedContainer == 'Sobrancelha'
                                              ? TimeOfDay(
                                                  hour: selectedTime.hour,
                                                  minute: (selectedTime.minute +
                                                          30) %
                                                      60,
                                                )
                                                  .format(context)
                                                  .replaceAllMapped(
                                                  RegExp(
                                                      r'(\d+:\d+) ([AaPp][Mm])'),
                                                  (match) {
                                                    int hour = int.parse(match
                                                        .group(1)!
                                                        .split(":")[0]);
                                                    if (match
                                                                .group(2)
                                                                ?.toLowerCase() ==
                                                            'pm' &&
                                                        hour < 12) {
                                                      hour += 12;
                                                    } else if (match
                                                                .group(2)
                                                                ?.toLowerCase() ==
                                                            'am' &&
                                                        hour == 12) {
                                                      hour = 0;
                                                    }
                                                    return '$hour:${match.group(1)!.split(":")[1]}';
                                                  },
                                                )
                                              : '--:--',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Qual o seu nome completo?',
                style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
              ),
              const SizedBox(height: 10),
              textfieldwidget(
                  controller: controllerNome,
                  maxLines: 1,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  hintText: 'Digite aqui...'),
              const SizedBox(height: 30),
              const Text(
                'Qual o seu e-mail',
                style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
              ),
              const SizedBox(height: 10),
              textfieldwidget(
                  controller: controllerEmail,
                  maxLines: 1,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Digite aqui...'),
              const SizedBox(height: 30),
              const Text(
                'Digite o seu telefone',
                style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
              ),
              const SizedBox(height: 10),
              textfieldwidget(
                  controller: controllerTelefone,
                  maxLines: 1,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  hintText: 'Digite aqui...'),
              const SizedBox(height: 30),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      validarDados();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 238, 163, 185),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13))),
                    child: const Center(
                      child: Text(
                        'Continuar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  )),
            ],
          )
        ],
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
