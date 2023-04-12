import 'package:flutter/material.dart';

class ClientAddView extends StatefulWidget {
  const ClientAddView({super.key});

  @override
  State<ClientAddView> createState() => _ClientAddViewState();
}

class _ClientAddViewState extends State<ClientAddView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Client'),
      ),
    );
  }
}
