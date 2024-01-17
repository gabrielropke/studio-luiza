import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studio_luiza_web/pages/home_page.dart';

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
        home: const HomePage());
  }
}