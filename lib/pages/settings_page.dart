import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  static const id = '/settings';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SETTINGS')),
      body: const Center(child: Text('SETTINGS')),
    );
  }
}
