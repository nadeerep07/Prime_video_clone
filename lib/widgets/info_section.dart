import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final String description;

  const InfoSection({Key? key, required this.title, required this.description})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const Divider(color: Colors.grey, thickness: 1, height: 40),
      ],
    );
  }
}
