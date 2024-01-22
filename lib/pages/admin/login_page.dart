import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studio_luiza_web/model/usuario_model.dart';
import 'package:studio_luiza_web/pages/admin/view/home_admin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  _validarCampos() {
    //Recupera dados dos campos
    String email = controllerEmail.text;
    String senha = controllerPassword.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty) {
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario(usuario);
      } else {
        setState(() {
          errorAlert();
        });
      }
    } else {
      setState(() {
        errorAlert();
      });
    }
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((FirebaseUser) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeAdmin())));
    }).catchError((error) {
      setState(() {
        errorAlert();
      });
    });
  }

  void errorAlert() {
    AwesomeDialog(
            width: 350,
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Atenção',
            desc: 'Verifique os dados de login',
            btnOkText: 'Voltar')
        .show();
  }

  bool isMobilesmaller(BuildContext context) =>
      MediaQuery.of(context).size.width <= 450;
  bool isMobilebigger(BuildContext context) =>
      MediaQuery.of(context).size.width > 450;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextoWidget(
                texto: 'Studio Luiza',
                size: isMobilesmaller(context) ? 40 : 52,
                fontFamily: 'Montserrat',
                letterSpacing: 5,
                corTexto: const Color(0xFF58578F),
              ),
              TextoWidget(
                texto: 'Acesso somente para equipe',
                size: isMobilesmaller(context) ? 12 : 16,
                fontFamily: '',
                letterSpacing: 5,
                corTexto: const Color(0xFF58578F),
              ),
              const SizedBox(height: 40),
              SizedBox(
                  width: 310,
                  child: TextFieldLogin(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black12,
                      ),
                      controller: controllerEmail,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Insira o seu e-mail')),
              const SizedBox(height: 10),
              SizedBox(
                width: 310,
                child: TextFieldLogin(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.black12,
                    ),
                    controller: controllerPassword,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Insira a sua senha'),
              ),
              const SizedBox(height: 10),
              const TextoWidget(
                texto: 'Esqueceu a senha?',
                size: 14,
                fontFamily: '',
                letterSpacing: 1,
                corTexto: Color(0xFF58578F),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 310,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      _validarCampos();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: const Color(0xFF58578F)),
                    child: const Center(
                      child: TextoWidget(
                        texto: 'Entrar',
                        size: 16,
                        fontFamily: 'Montserrat',
                        letterSpacing: 1,
                        corTexto: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin(
      {super.key,
      required this.controller,
      this.prefixIcon,
      this.suffixIcon,
      required this.obscureText,
      required this.keyboardType,
      required this.hintText,
      this.maxLength,
      this.maxLines});

  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String hintText;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.black12)),
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        hintText: hintText,
        hintStyle: const TextStyle(
            fontFamily: '',
            color: Color.fromARGB(255, 189, 185, 185),
            fontWeight: FontWeight.w300),
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
      required this.letterSpacing,
      required this.corTexto});

  final String texto;
  final double size;
  final String fontFamily;
  final double letterSpacing;
  final Color corTexto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
          color: corTexto,
          fontSize: size,
          fontFamily: fontFamily,
          letterSpacing: letterSpacing),
      textAlign: TextAlign.center,
    );
  }
}
