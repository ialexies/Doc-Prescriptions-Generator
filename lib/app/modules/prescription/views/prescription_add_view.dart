import 'package:flutter/material.dart';

class PrescriptionAddView extends StatefulWidget {
  const PrescriptionAddView({super.key});

  @override
  State<PrescriptionAddView> createState() => _PrescriptionAddViewState();
}

class _PrescriptionAddViewState extends State<PrescriptionAddView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Client'),
      ),
    );
  }
}
