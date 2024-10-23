import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  String verificationid;
  OtpScreen({super.key, required this.verificationid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "otp screen",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Otp",
                suffixIcon: const Icon(
                  Icons.phone,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                PhoneAuthCredential credential =
                    await PhoneAuthProvider.credential(
                        verificationId: widget.verificationid,
                        smsCode: otpController.text.toString());
                FirebaseAuth.instance
                    .signInWithCredential(credential)
                    .then((onValue) {
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                        title: "My home page",
                      ),
                    ),
                  );
                });
              } catch (ex) {
                log(ex.toString() as num);
              }
            },
            child: const Text("Enter Otp"),
          ),
        ],
      ),
    );
  }
}
