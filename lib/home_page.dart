import 'package:countdown_flutter/widgets/countdown_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _eventController = TextEditingController();

  final _dateController = TextEditingController();

  List<String> event = [];

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
            return CountDownCard(_eventController.text.toString());
          },
        ));
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
                                final teste = _eventController.text.toString();
                                event.add(teste);
                                Navigator.of(context).pop();
                                setState(() {});
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
}
