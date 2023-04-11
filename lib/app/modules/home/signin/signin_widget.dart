import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({
    super.key,
    required this.providerConfigs,
  });

  final List<EmailProviderConfiguration> providerConfigs;

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: providerConfigs,
      headerBuilder: (context, constraints, _) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              'https://firebase.flutter.dev/img/flutterfire_300x.png',
            ),
          ),
        );
      },
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          final auth = FirebaseAuth.instance;
          final user = auth.currentUser;
          final uid = user?.uid;

          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({})
              .then((value) => log('User Details'))
              .catchError((err) async {
                log('Failed to add user: $err');
              });

          Navigator.pushReplacementNamed(context, '/home');
        }),
      ],
    );
  }
}
