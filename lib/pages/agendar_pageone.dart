import 'package:flutter/material.dart';
import 'package:studio_luiza_web/widgets/page_one_agenda/model_widget.dart';

class AgendarPageOne extends StatefulWidget {
  const AgendarPageOne({super.key});

  @override
  State<AgendarPageOne> createState() => _AgendarPageOneState();
}

final TextEditingController controllerObservacao = TextEditingController();

class _AgendarPageOneState extends State<AgendarPageOne> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0x000fffff),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: ModelWidget(),
        ),
      ),
    );
  }
}
