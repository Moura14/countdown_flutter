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
  List event = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
      height: 115,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 70,
                    top: 15,
                  ),
                  child: Column(
                    children: [
                      Text(
                        event[index]['title'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TimerCountdown(
                        format: CountDownTimerFormat.daysHoursMinutesSeconds,
                        endTime:
                            DateTime.parse(event[index]['data'].toString()),
                        onEnd: () {
                          print('Acabou');
                        },
                      )
                    ],
                  ),
                ),
                Positioned(
                    left: 340,
                    child: IconButton(
                        onPressed: () {
                          _showDialog(context, index);
                        },
                        icon: const Icon(Icons.delete_outline)))
              ],
            )),
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
                        focusNode: _itemFocus,
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

  void _showDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (contex) {
          return AlertDialog(
            title: const Text('Deseja excluir esse evento?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const [Text('Todo o conteúdo sera removido')],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _countDownRemove = Map.from(event[index]);
                      event.removeAt(index);
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('Ok')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'))
            ],
          );
        });
  }

  void _addList() {
    setState(() {
      Map<String, dynamic> newList = {};
      newList['title'] = _eventController.text;
      _eventController.text = "";
      final value = _dateController.text;
      final split = value.split('/');
      newList['data'] = split.reversed.join('-');
      _dateController.text = "";
      event.add(newList);
      Navigator.of(context).pop();
    });
  }
}
