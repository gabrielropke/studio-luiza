import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:studio_luiza_web/widgets/textfield_widget.dart';

class CadastroEndereco extends StatefulWidget {
  final TextEditingController ruaController;
  final TextEditingController numeroController;
  final TextEditingController ufController;
  final TextEditingController cidadeController;
  final TextEditingController cepController;
  final TextEditingController bairroController;
  final TextEditingController compController;
  const CadastroEndereco(
      {Key? key,
      required this.ruaController,
      required this.numeroController,
      required this.ufController,
      required this.cidadeController,
      required this.cepController,
      required this.bairroController,
      required this.compController})
      : super(key: key);

  @override
  State<CadastroEndereco> createState() => _CadastroEnderecoState();
}

class _CadastroEnderecoState extends State<CadastroEndereco> {
  String? valueChoose;
  late TextEditingController ruaController;
  late TextEditingController numeroController;
  late TextEditingController ufController;
  late TextEditingController cidadeController;
  late TextEditingController cepController;
  late TextEditingController bairroController;
  late TextEditingController compController;

  Future<Map<String, dynamic>> consultarCEP(String cep) async {
    var url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha na consulta do CEP.');
    }
  }

  @override
  void initState() {
    ruaController = widget.ruaController;
    ufController = widget.ufController;
    cidadeController = widget.cidadeController;
    bairroController = widget.bairroController;
    cepController = widget.cepController;
    numeroController = widget.numeroController;
    compController = widget.compController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cepController.addListener(() {
      String cep = cepController.text;
      if (cep.length == 8) {
        consultarCEP(cep).then((data) {
          setState(() {
            cidadeController.text = data['localidade'];
            ufController.text = data['uf'];
            ruaController.text = data['logradouro'];
            bairroController.text = data['bairro'];
            valueChoose = data['titulo'];
          });
        }).catchError((error) {
          print(error);
        });
      }
    });
    return Column(
      children: [
        textfieldwidget(
            controller: cepController,
            maxLines: 1,
            obscureText: false,
            keyboardType: TextInputType.name,
            hintText: 'CEP'),
        const SizedBox(height: 15),
        textfieldwidget(
            controller: ufController,
            maxLines: 1,
            obscureText: false,
            keyboardType: TextInputType.name,
            hintText: 'Estado'),
        const SizedBox(height: 15),
        textfieldwidget(
            controller: cidadeController,
            maxLines: 1,
            obscureText: false,
            keyboardType: TextInputType.name,
            hintText: 'Cidade'),
        const SizedBox(height: 15),
        textfieldwidget(
            controller: bairroController,
            maxLines: 1,
            obscureText: false,
            keyboardType: TextInputType.name,
            hintText: 'Bairro'),
        const SizedBox(height: 15),
        textfieldwidget(
            controller: ruaController,
            maxLines: 1,
            obscureText: false,
            keyboardType: TextInputType.name,
            hintText: 'Rua'),
        const SizedBox(height: 15),
        textfieldwidget(
            controller: numeroController,
            maxLines: 1,
            obscureText: false,
            keyboardType: TextInputType.name,
            hintText: 'Número'),
        const SizedBox(height: 15),
        textfieldwidget(
            controller: compController,
            maxLines: 1,
            obscureText: false,
            keyboardType: TextInputType.name,
            hintText: 'Complemento/Referência'),
        const SizedBox(height: 30),
      ],
    );
  }
}
