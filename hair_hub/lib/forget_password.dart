import 'package:flutter/material.dart';
import 'package:hair_hub/barber_signin.dart';
import 'package:hair_hub/customer_signin.dart';
import 'auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      // List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);
      // print('Sign-in methods for $email: $signInMethods');
      QuerySnapshot customerQuery = await firestore
          .collection('customer')
          .where('email', isEqualTo: email)
          .get();
      QuerySnapshot barberQuery = await firestore
          .collection('barber')
          .where('email', isEqualTo: email)
          .get();

      if (customerQuery.docs.isNotEmpty || barberQuery.docs.isNotEmpty) {
        await auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email sent')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email is not registered')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Failed to send password reset email: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Forgot Password'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => sign_in_customer(),
                  ));
            },
          ),
          backgroundColor: Color(0xFF404040)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Color(0xFFECB72B)),
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFECB72B), width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  resetPassword(email, context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter your email')),
                  );
                }
              },
              child: Text('Reset Password'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFECB72B),
                foregroundColor: Color(0xFF404040),
                // fixedSize: Size(200, 50),
                // shape: StadiumBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
