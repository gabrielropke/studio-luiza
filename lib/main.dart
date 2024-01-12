import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studio_luiza_web/pages/agendar_pageone.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/model_widget_pagetwo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyByq_m7sD7oNsbu9t_P02LWd9JwXtbuCVo",
          projectId: "studio-luiza",
          messagingSenderId: "214428194508",
          appId: "1:214428194508:web:7ecba1ab769fabaa905469"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Studio Luiza',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        ),
        home: ModelWidgetPageTwo(
          servico: 'Cílios',
          horario: TimeOfDay(hour: 12, minute: 12),
          nome: 'nome',
          email: 'email',
          telefone: 'telefone',
          data: DateTime.now(),
        ));
  }
}

// ModelWidgetPageTwo(
//           servico: 'servico',
//           horario: TimeOfDay(hour: 12, minute: 12),
//           nome: 'nome',
//           email: 'email',
//           telefone: 'telefone',
//           data: DateTime.now(),
//         )