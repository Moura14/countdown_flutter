import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class CountDownCard extends StatelessWidget {
  final String title;

  const CountDownCard(this.title, {super.key});

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
            const SlideCountdown(
              textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              decoration: BoxDecoration(),
              duration: Duration(days: 354),
              separatorType: SeparatorType.title,
              slideDirection: SlideDirection.up,
            ),
          ],
        ),
      ),
    );
  }
}
