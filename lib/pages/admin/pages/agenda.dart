import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<DateTime> _eventDates = [];

  String formatarData(DateTime data) {
    final formatoData = DateFormat('dd/MM/yy');
    return formatoData.format(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 134, 136, 173)),
              todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 180, 210, 211)),
            ),
            firstDay: DateTime.utc(2023, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            eventLoader: (day) {
              return _eventDates
                  .where((eventDate) => isSameDay(eventDate, day))
                  .toList();
            },
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('agendamentos')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator()),
                );
              }

              var agendamentos = snapshot.data?.docs;

              // Limpar a lista de eventos antes de preenchê-la
              _eventDates.clear();

              agendamentos?.forEach((agendamento) {
                var dataAgendamento = agendamento.data()['data'].toDate();
                if (!_eventDates.contains(dataAgendamento)) {
                  _eventDates.add(dataAgendamento);
                }
              });

              var agendamentosNaDataSelecionada = agendamentos?.where(
                  (agendamento) =>
                      formatarData(_selectedDay) ==
                          formatarData(agendamento.data()['data'].toDate()) &&
                      agendamento.data()['status'] == 'Aprovado');

              if (agendamentosNaDataSelecionada == null ||
                  agendamentosNaDataSelecionada.isEmpty) {
                // Retornar o texto desejado quando não há agendamentos
                return const Padding(
                  padding: EdgeInsets.only(top: 250),
                  child: Text(
                    'Não há agendamentos\npara esta data.',
                    style: TextStyle(fontSize: 26, color: Colors.black26, fontFamily: 'Montserrat'), textAlign: TextAlign.center,
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: agendamentos!.map(
                    (agendamento) {
                      // ignore: unused_local_variable
                      var agendamentoId = agendamento.data()['agendamentoid'];
                      var horario = agendamento.data()['horario'];
                      var data = agendamento.data()['data'];
                      var servico = agendamento.data()['servico'];
                      var subservico = agendamento.data()['subservico'];
                      var status = agendamento.data()['status'];

                      return Column(
                        children: [
                          Visibility(
                            visible: formatarData(_selectedDay) ==
                                    formatarData(data.toDate()) &&
                                status == 'Aprovado',
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: servico == 'Maquiagem'
                                        ? const Color(0xFFDA728B)
                                        : servico == 'Cílios'
                                            ? const Color(0xFFAA73CA)
                                            : servico == 'Sobrancelha'
                                                ? const Color(0xFF5284DA)
                                                : servico == 'Manutenção'
                                                    ? const Color(0xFF40B9BE)
                                                    : Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: ListTile(
                                      title: Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          '$servico - $subservico',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: 2),
                                        ),
                                      ),
                                      subtitle: Text(
                                        '$horario - ${formatarData(data.toDate())}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            letterSpacing: 2),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
