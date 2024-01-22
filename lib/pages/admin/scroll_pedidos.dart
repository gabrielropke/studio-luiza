import 'package:flutter/material.dart';
import 'package:studio_luiza_web/pages/admin/pages/pedidos.dart';

class scroll_pedidos extends StatefulWidget {
  const scroll_pedidos({Key? key}) : super(key: key);

  @override
  State<scroll_pedidos> createState() => _scroll_pedidosState();
}

class _scroll_pedidosState extends State<scroll_pedidos> {
  bool isMobilesmaller(BuildContext context) =>
      MediaQuery.of(context).size.width <= 450;
  bool isMobilebigger(BuildContext context) =>
      MediaQuery.of(context).size.width > 450;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
              child: Container(
                height: 35,
                width: 400,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 244, 243),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 244, 244, 243),
                      width: 3,
                    ),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  labelColor: const Color.fromARGB(255, 0, 0, 0),
                  unselectedLabelColor:
                      const Color.fromARGB(255, 211, 207, 207),
                  tabs: const [
                    Tab(
                      child: Text(
                        'Pendentes',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Aprovados',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Cancelados',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: TabBarView(children: [
                AgendamentosList(statusWidget: 'Pendente'),
                AgendamentosList(statusWidget: 'Aprovado'),
                AgendamentosList(statusWidget: 'Cancelado'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
