// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:lottie/lottie.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({
    super.key,
    required this.providerConfigs,
  });

  final List<EmailProviderConfiguration> providerConfigs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SignInScreen(
          providerConfigs: providerConfigs,
          headerBuilder: (context, constraints, _) {
            return Lottie.asset(
              'assets/images/doctor_signin_animation.json',
            );
          },
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) async {
              final auth = FirebaseAuth.instance;
              final user = auth.currentUser;
              final uid = user?.uid;

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .update({})
                  .then((value) => log('User Details'))
                  .catchError((err) async {
                    log('Failed to add user: $err');
                  });

              if (context.mounted) {
                await Navigator.pushReplacementNamed(context, '/home');
              }
            }),
          ],
        ),
      ),
    );
  }
}
