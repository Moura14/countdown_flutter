import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CountDownCard extends StatelessWidget {
  final String title;
  final streamDuration = StreamDuration(const Duration(hours: 2));

  CountDownCard(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TimerCountdown(
                format: CountDownTimerFormat.daysHoursMinutesSeconds,
                endTime: DateTime.now().add(const Duration(
                    days: 2, hours: 2, minutes: 30, seconds: 34)))
          ],
        ),
      ),
    );
  }
}
