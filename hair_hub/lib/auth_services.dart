// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hair_hub/hair_style.dart';
import 'package:hair_hub/set_slots.dart';
import 'package:hair_hub/shops_available.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      UserCredential uc = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (uc.user != null) {
        print("User created: ${uc.user!.uid}");
        auth.currentUser!.updateDisplayName(name);
        await _firestore.collection('customer').doc(uc.user!.uid).set({
          'email': email,
          'name': name,
          'role': 'customer',
        });
        print("Data saved in Firestore");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Customer Registration successful"),
        ));
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const Screen()));
      }
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Screen()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUp2(
      String shopname,
      String contactno,
      String email,
      String password,
      String url,
      String? address,
      BuildContext context) async {
    try {
      UserCredential uc = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (uc.user != null) {
        print("User created: ${uc.user!.uid}");
        auth.currentUser!.updateDisplayName(shopname);
        // Save additional information in Firestore
        await _firestore.collection('barbers').doc(uc.user!.uid).set({
          'email': email,
          'shopName': shopname,
          'contact': contactno,
          'url': url,
          'address': address,
          'role': 'barber',
        });
        print("Data saved in Firestore");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Barbar Registration successful"),
        ));
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const Screen()));
      }
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Screen()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential uc = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (uc.user != null) {
        String uid = uc.user!.uid;
        print(uid);
        DocumentSnapshot customerDoc =
            await _firestore.collection('customer').doc(uid).get();
        if (customerDoc.exists) {
          String role = customerDoc.get('role');
          if (role == 'customer') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Customer Login successful"),
            ));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ShopListScreen()),
            );
            return;
          }
        }
        DocumentSnapshot barberDoc =
            await _firestore.collection('barbers').doc(uid).get();
        if (barberDoc.exists) {
          String role = barberDoc.get('role');
          if (role == 'barber') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Barbar Login successful"),
            ));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SlotScreen()),
            );
            return;
          }
        }

        // DocumentSnapshot userDoc =
        //     await _firestore.collection('users').doc(uid).get();
        // String role = userDoc.get('name');
        // if (role == 'customer') {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text("Customer Login successful"),
        //   ));
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => ShopListScreen()),
        //   );
        // } else if (role == 'barber') {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text("barbar Login successful"),
        //   ));
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => SlotScreen()),
        //   );
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Unknown role')),
        //   );
        // }
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text("Login successful"),
        // ));
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const Screen()));
      }
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Screen()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      print(e);
    }
  }

  signOut(BuildContext context) async {
    await auth.signOut();
    // .whenComplete(() => Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const sign_in())));
  }
}
