import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _eventController = TextEditingController();
  final _dateController = TextEditingController();
  Map<String, dynamic> _countDownRemove = {};
  final _itemFocus = FocusNode();
  final List event = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('CountDown Flutter'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            _dialog(context);
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: event.length,
          itemBuilder: (BuildContext context, int index) {
            return _countDownCard(context, index);
          },
        ));
  }

  Widget _countDownCard(BuildContext context, int index) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: GestureDetector(
          onTap: () {
            _showBottom(context, index);
          },
          child: Column(
            children: [
              Text(
                event[index]['title'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TimerCountdown(
                format: CountDownTimerFormat.daysHoursMinutesSeconds,
                endTime: DateTime.utc(event[index]['data']),
                onEnd: () {
                  print('Acabou!');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Adicione contagem regressiva'),
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: _eventController,
                        decoration: const InputDecoration(labelText: "Evento"),
                      ),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter()
                        ],
                        controller: _dateController,
                        keyboardType: TextInputType.datetime,
                        decoration:
                            const InputDecoration(labelText: "Data do evento"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(color: Colors.black),
                              )),
                          TextButton(
                              onPressed: () {
                                if (_eventController.text.isNotEmpty &&
                                    _dateController.text.isNotEmpty) {
                                  _addList();
                                } else {
                                  FocusScope.of(context)
                                      .requestFocus(_itemFocus);
                                }
                              },
                              child: const Text(
                                'Adicionar',
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      )
                    ],
                  )),
            ],
          );
        });
  }

  void _showBottom(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Editar',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _countDownRemove = Map.from(event[index]);
                          event.removeAt(index);
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text(
                        'Excluir',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          );
        }));
  }

  void _addList() {
    setState(() {
      Map<String, dynamic> newList = {};
      newList['title'] = _eventController.text;
      _eventController.text = "";
      final value = _dateController.text;
      final split = value.split('/');
      newList['data'] = split;
      _dateController.text = "";
      print(newList);
      // event.add(newList);
      // Navigator.of(context).pop();
    });
  }
}
