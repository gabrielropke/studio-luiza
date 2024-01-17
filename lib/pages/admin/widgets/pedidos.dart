import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studio_luiza_web/pages/resume_page.dart';

class AgendamentosList extends StatelessWidget {
  const AgendamentosList({super.key, required this.statusWidget});

  final String statusWidget;

  Color gerarCorAleatoria() {
    Random random = Random();
    int maxChannelValue =
        150; // Ajuste o valor máximo para obter tons mais escuros

    return Color.fromARGB(
      180,
      random.nextInt(maxChannelValue + 1),
      random.nextInt(maxChannelValue + 1),
      random.nextInt(maxChannelValue + 1),
    );
  }

  String obterPrimeiroESegundoNome(String nomeCompleto) {
    List<String> partesDoNome = nomeCompleto.split(' ');

    if (partesDoNome.length >= 2) {
      return '${partesDoNome[0]} ${partesDoNome[1]}';
    } else {
      return nomeCompleto;
    }
  }

  String formatarData(DateTime data) {
    final formatoData = DateFormat('dd/MM/yy');
    return formatoData.format(data);
  }

  abrirEndereco(BuildContext context, rua, numero, bairro, cidade, uf, cep) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: 300,
              height: 120,
              child: container_widget(
                titulo: 'Endereço',
                subtitulo: '$rua, $numero,\n$bairro,\n$cidade - $uf, $cep',
                icone: const Icon(Icons.share_location_rounded),
              ),
            ),
          );
        });
  }

  validarPedido(BuildContext context, idAgendamento) {
    AwesomeDialog(
            width: 300,
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Como vai ser?',
            btnOkOnPress: () {
              aprovarPedido(context, idAgendamento);
            },
            btnCancelOnPress: () {
              cancelarPedido(context, idAgendamento);
            },
            btnCancelText: 'Recusar',
            btnOkText: 'Aceitar')
        .show();
  }

  aprovarPedido(BuildContext context, String agendamentoId) {
    FirebaseFirestore.instance
        .collection('agendamentos')
        .doc(agendamentoId)
        .update({'status': 'Aprovado'}).then((value) {
      // Mostra o diálogo de sucesso
      AwesomeDialog(
              width: 300,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              title: 'Pronto!',
              desc: 'Pedido aprovado com sucesso.',
              btnOkText: 'Ok')
          .show();
    }).catchError((error) {
      AwesomeDialog(
              width: 300,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Erro!',
              desc: 'Ocorreu um erro ao aprovar o pedido.',
              btnOkText: 'Ok')
          .show();
    });
  }

  cancelarPedido(BuildContext context, String agendamentoId) {
    FirebaseFirestore.instance
        .collection('agendamentos')
        .doc(agendamentoId)
        .update({'status': 'Cancelado'}).then((value) {
      AwesomeDialog(
              width: 300,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Feito!',
              desc: 'Pedido cancelado com sucesso.',
              btnOkText: 'Ok')
          .show();
    }).catchError((error) {
      AwesomeDialog(
              width: 300,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Erro!',
              desc: 'Ocorreu um erro ao aprovar o pedido.',
              btnOkText: 'Ok')
          .show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('agendamentos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
      
          var agendamentos = snapshot.data?.docs;
      
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: agendamentos!.map((agendamento) {
              var agendamentoId = agendamento.data()['agendamentoid'];
              var servico = agendamento.data()['servico'];
              var subservico = agendamento.data()['subservico'];
              var status = agendamento.data()['status'];
              var nomeCliente = agendamento.data()['nome'];
              var horario = agendamento.data()['horario'];
              var data = agendamento.data()['data'];
              var rua = agendamento.data()['rua'];
              var numero = agendamento.data()['numero'];
              var bairro = agendamento.data()['bairro'];
              var cidade = agendamento.data()['cidade'];
              var uf = agendamento.data()['uf'];
              var cep = agendamento.data()['cep'];
              return Visibility(
                visible: status == statusWidget,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Container(
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: gerarCorAleatoria()),
                            child: Center(
                              child: Text(
                                nomeCliente.isNotEmpty
                                    ? nomeCliente.substring(0, 1).toUpperCase()
                                    : '', // Verifica se o nomeCliente não está vazio
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    obterPrimeiroESegundoNome(nomeCliente),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Container(
                                    width: 90,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: status == 'Aprovado'
                                            ? Colors.green
                                            : status == 'Cancelado'
                                                ? const Color(0xFFEFA4A4)
                                                : Colors.redAccent,
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Center(
                                        child: Text(
                                      status,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  )
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    validarPedido(context, agendamentoId);
                                  },
                                  child: const Icon(Icons.more_horiz))
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('$servico às ${horario}h',
                                      style: const TextStyle(
                                          fontSize: 15, letterSpacing: 1)),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                          '${formatarData(data.toDate())} - $subservico',
                                          style: const TextStyle(
                                              fontSize: 15, letterSpacing: 1)),
                                      const SizedBox(width: 10),
                                      if (subservico == 'Em domicílio')
                                        GestureDetector(
                                          onTap: () {
                                            abrirEndereco(context, rua, numero,
                                                bairro, cidade, uf, cep);
                                          },
                                          child: const Icon(
                                            Icons.visibility_rounded,
                                            color: Colors.black38,
                                          ),
                                        )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  PriceWidget(
                                      servico: servico, subServico: subservico),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key, required this.servico, required this.subServico});

  final String servico;
  final String subServico;

  @override
  Widget build(BuildContext context) {
    return Text(
      servico == 'Cílios' && subServico == 'Volume Brasileiro'
          ? 'R\$130,00'
          : servico == 'Cílios' && subServico == 'Volume Europeu'
              ? 'R\$150,00'
              : servico == 'Cílios' && subServico == 'Volume Egípcio'
                  ? 'R\$140,00'
                  : servico == 'Cílios' && subServico == 'Volume Luxo'
                      ? 'R\$160,00'
                      : servico == 'Cílios' && subServico == 'Volume Brasileiro'
                          ? 'R\$140,00'
                          : servico == 'Maquiagem' &&
                                  subServico == 'Studio Luiza'
                              ? 'R\$130,00'
                              : servico == 'Maquiagem' &&
                                      subServico == 'Em domicílio'
                                  ? 'R\$150,00'
                                  : servico == 'Manutenção' &&
                                          subServico == 'Volume Brasileiro'
                                      ? 'R\$65,00'
                                      : servico == 'Manutenção' &&
                                              subServico == 'Volume Europeu'
                                          ? 'R\$75,00'
                                          : servico == 'Manutenção' &&
                                                  subServico == 'Volume Egípcio'
                                              ? 'R\$70,00'
                                              : servico == 'Manutenção' &&
                                                      subServico ==
                                                          'Volume Luxo'
                                                  ? 'R\$80,00'
                                                  : servico == 'Sobrancelha' &&
                                                          subServico ==
                                                              'Design de sobrancelha'
                                                      ? 'R\$20,00'
                                                      : servico ==
                                                                  'Sobrancelha' &&
                                                              subServico ==
                                                                  'Design com enna'
                                                          ? 'R\$25,00'
                                                          : servico ==
                                                                      'Sobrancelha' &&
                                                                  subServico ==
                                                                      'Design com tintura'
                                                              ? 'R\$30,00'
                                                              : servico ==
                                                                          'Sobrancelha' &&
                                                                      subServico ==
                                                                          'Brow Lamination'
                                                                  ? 'R\$60,00'
                                                                  : 'Verificar com studio',
      style: const TextStyle(
          fontFamily: '',
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
          fontSize: 25,
          color: Colors.black87),
    );
  }
}
