import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:slide_countdown/slide_countdown.dart';

class CountDownCard extends StatelessWidget {
  final String title;
  Function function;
  final streamDuration = StreamDuration(const Duration(hours: 2));

  CountDownCard(this.title, this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
          child: GestureDetector(
        onTap: () {
          function();
        },
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TimerCountdown(
              endTime: DateTime.now().add(
                  const Duration(days: 5, hours: 14, minutes: 27, seconds: 21)),
              onEnd: () {
                print('Acabou!');
              },
            )
          ],
        ),
      )),
    );
  }
}
