import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studio_luiza_web/pages/agendar_pageone.dart';
import 'package:studio_luiza_web/pages/resume_page.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/cilios_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBD5yiA4m9tI4MVE37OW4gV-83FpR858TE",
          projectId: "studioluiza-ce668",
          messagingSenderId: "1057345054637",
          appId: "1:1057345054637:web:b533b8b4b5882e86746324"));
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
        home: const AgendarPageOne());
  }
}
