import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  final String title;
  const LanguageTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.white,
      ),
      onTap: () {},
    );
  }
}
