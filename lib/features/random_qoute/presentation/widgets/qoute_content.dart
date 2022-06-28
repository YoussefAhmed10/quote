import 'package:flutter/material.dart';
import 'package:qoutes/features/random_qoute/domain/entities/qoute.dart';

class QouteContent extends StatelessWidget {
  const QouteContent({Key? key, required this.qoute}) : super(key: key);
  final Qoute qoute;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          qoute.content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          qoute.author,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
