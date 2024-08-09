// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_final_fields
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hair_hub/customer_signin.dart';
import 'package:hair_hub/map_screen.dart';

import 'barber_signin.dart';
import 'auth_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class sign_up extends StatefulWidget {
  final String? value;
  sign_up({this.value});
  // sign_up({required this.value});
  // const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  bool _obscuretext = true;
  bool isLoading = false;

  TextEditingController email_c = TextEditingController();
  TextEditingController password_c = TextEditingController();
  TextEditingController shopname_c = TextEditingController();
  TextEditingController contact_c = TextEditingController();
  TextEditingController location_c = TextEditingController();

  File? _image;
  bool _isUploading = false;
  String downloadURL = '';
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _pickImage(ImageSource source) async {
    // final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _isUploading = true; // Show the progress indicator
    });
    try {
      final pickedFile = await _picker.pickImage(source: source);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          print('Image selected: ${pickedFile.path}');
        } else {
          print('No image selected.');
          setState(() {
            _isUploading = false;
          });
        }
      });
    } catch (e) {
      print('Error picking image: $e');
    }
    if (_image == null) {
      print('No image to upload.');
      setState(() {
        _isUploading = false;
      });
      return;
    }

    try {
      // Create a unique file name for the image
      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Upload the image to Firebase Storage
      UploadTask uploadTask = _storage.ref(fileName).putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL of the uploaded image
      downloadURL = await taskSnapshot.ref.getDownloadURL();

      // Save the download URL in Firestore
      // await _firestore.collection('barber').add({
      //   'url': downloadURL,
      //   'uploaded_at': Timestamp.now(),
      // });

      print('Image uploaded successfully: $downloadURL');
      print(widget.value);

      // Show a snackbar after the upload is complete
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );
    } catch (e) {
      print('Error uploading image: $e');

      // Show a snackbar in case of an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false; // Hide the progress indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _SignUp() async {
      // Simulating the data sending process
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1));
      AuthService().signUp2(shopname_c.text, contact_c.text, email_c.text,
          password_c.text, downloadURL, widget.value, context);

      // Simulating the data receiving process
      setState(() {
        isLoading = false;
      });
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Hair Hub",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF404040),
        ),
        body: orientation == Orientation.portrait
            ? Container(
                height: height * 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.white, Colors.white])),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height * 0.25,
                            width: width * 10,
                            decoration: BoxDecoration(
                              // border: Border(
                              //     bottom: BorderSide(
                              //         color: Color(0xFFECB72B), width: 2.0),
                              //     right: BorderSide(
                              //         color: Color(0xFFECB72B), width: 2.0)),
                              // borderRadius: BorderRadius.only(
                              //     bottomRight: Radius.circular(70)),
                              color: Colors.white12,
                            ),
                          ),
                          Image.asset(
                            "assets/logo1.png",
                            width: 200,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          //   child: Text(
                          //     "Create Account",
                          //     style: TextStyle(
                          //       fontSize: 30,
                          //       color: Color(0xFFECB72B),
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //     padding: EdgeInsets.fromLTRB(25, 80, 0, 0),
                          //     child: Text(
                          //       "Sign up and get started",
                          //       style: TextStyle(
                          //         fontSize: 20,
                          //         color: Color(0xFF404040),
                          //       ),
                          //     )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 0, 0, 10),
                        child: Text("Email",
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 20),
                        child: TextFormField(
                          controller: email_c,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.email, color: Color(0xFFECB72B)),
                              hintText: "Enter email",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFECB72B)),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF404040)),
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(62, 0, 20, 15),
                        child: Row(
                          children: [
                            Text("Shop Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 5, 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: shopname_c,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color(0xFFECB72B),
                                  ),
                                  hintText: "Full name",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFECB72B)),
                                      borderRadius: BorderRadius.circular(50)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF404040)),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Full name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(62, 0, 20, 15),
                        child: Row(
                          children: [
                            Text("Contact no",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 5, 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: contact_c,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color(0xFFECB72B),
                                  ),
                                  hintText: "03xxxxxxxxx",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFECB72B)),
                                      borderRadius: BorderRadius.circular(50)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF404040)),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Full name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 0, 0, 10),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 15),
                        child: TextFormField(
                          controller: password_c,
                          obscureText: _obscuretext,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Color(0xFFECB72B),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscuretext = !_obscuretext;
                                });
                              },
                              child: Icon(
                                color: Color(0xFFECB72B),
                                _obscuretext
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            hintText: "Set password",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFECB72B)),
                                borderRadius: BorderRadius.circular(50)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF404040)),
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 10, 5, 20),
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.location_on_outlined),

                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LocationPickerScreen()),
                                );
                              },

                              // onPressed: isLoading ? null : () => _SignUp(),
                              // child: isLoading
                              //     ? CircularProgressIndicator(
                              //         valueColor: AlwaysStoppedAnimation<Color>(
                              //             Colors.white),
                              //       )
                              //     : Text("Set Location",
                              //         style: TextStyle(
                              //           fontSize: 20,
                              //         )),
                              label: Text(
                                "Set Location",
                                style: TextStyle(fontSize: 10),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF404040),
                                foregroundColor:
                                    Color.fromRGBO(236, 183, 43, 1),
                                fixedSize: Size(width * 0.38, height * 0.07),
                                shape: StadiumBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 30, 20),
                            child: ElevatedButton(
                              child: _isUploading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Color.fromRGBO(236, 183, 43, 1),
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.photo_library),
                                        SizedBox(width: 2),
                                        Flexible(
                                          child: Text(
                                            'Upload shops image',
                                            style: TextStyle(fontSize: 10),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),

                              // icon: Icon(Icons.camera_alt_outlined),

                              onPressed: _isUploading
                                  ? null
                                  : () => _pickImage(ImageSource.gallery),

                              // onPressed: isLoading ? null : () => _SignUp(),
                              // child: isLoading
                              //     ? CircularProgressIndicator(
                              //         valueColor: AlwaysStoppedAnimation<Color>(
                              //             Colors.white),
                              //       )
                              //     : Text("Set Location",
                              //         style: TextStyle(
                              //           fontSize: 20,
                              //         )),
                              // label: Text(
                              //   "upload shop's image",
                              //   style: TextStyle(fontSize: 10),
                              // ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF404040),
                                foregroundColor:
                                    Color.fromRGBO(236, 183, 43, 1),
                                fixedSize: Size(width * 0.38, height * 0.07),
                                shape: StadiumBorder(),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 10, 30, 20),
                        child: ElevatedButton(
                          // onPressed: () {},
                          onPressed: isLoading ? null : () => _SignUp(),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text("Sign up",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFECB72B),
                            foregroundColor: Color(0xFF404040),
                            fixedSize: Size(400, 50),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                        child: Row(children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(color: Color(0xFF404040)),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => sign_in_customer(),
                                    ));
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(color: Color(0xFFECB72B)),
                              ))
                        ]),
                      ),
                    ],
                  ),
                ))
            : Container(
                height: height * 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.white, Colors.white])),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height * 0.25,
                            width: width * 10,
                            decoration: BoxDecoration(
                              // border: Border(
                              //     bottom: BorderSide(
                              //         color: Color(0xFFECB72B), width: 2.0),
                              //     right: BorderSide(
                              //         color: Color(0xFFECB72B), width: 2.0)),
                              // borderRadius: BorderRadius.only(
                              //     bottomRight: Radius.circular(70)),
                              color: Colors.white12,
                            ),
                          ),
                          Image.asset(
                            "assets/logo1.png",
                            width: 200,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          //   child: Text(
                          //     "Create Account",
                          //     style: TextStyle(
                          //       fontSize: 30,
                          //       color: Color(0xFFECB72B),
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //     padding: EdgeInsets.fromLTRB(25, 80, 0, 0),
                          //     child: Text(
                          //       "Sign up and get started",
                          //       style: TextStyle(
                          //         fontSize: 20,
                          //         color: Color(0xFF404040),
                          //       ),
                          //     )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 0, 0, 10),
                        child: Text("Email",
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 20),
                        child: TextFormField(
                          controller: email_c,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.email, color: Color(0xFFECB72B)),
                              hintText: "Enter email",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFECB72B)),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF404040)),
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(62, 0, 20, 15),
                        child: Row(
                          children: [
                            Text("Shop Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 5, 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: shopname_c,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color(0xFFECB72B),
                                  ),
                                  hintText: "Full name",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFECB72B)),
                                      borderRadius: BorderRadius.circular(50)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF404040)),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Full name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(62, 0, 20, 15),
                        child: Row(
                          children: [
                            Text("Contact no",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 5, 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: contact_c,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color(0xFFECB72B),
                                  ),
                                  hintText: "03xxxxxxxxx",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFECB72B)),
                                      borderRadius: BorderRadius.circular(50)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF404040)),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Full name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(65, 0, 0, 10),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 30, 15),
                        child: TextFormField(
                          controller: password_c,
                          obscureText: _obscuretext,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Color(0xFFECB72B),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscuretext = !_obscuretext;
                                });
                              },
                              child: Icon(
                                color: Color(0xFFECB72B),
                                _obscuretext
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            hintText: "Set password",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFECB72B)),
                                borderRadius: BorderRadius.circular(50)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF404040)),
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 30, 20),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.location_on_outlined),

                          onPressed: () {},

                          // onPressed: isLoading ? null : () => _SignUp(),
                          // child: isLoading
                          //     ? CircularProgressIndicator(
                          //         valueColor: AlwaysStoppedAnimation<Color>(
                          //             Colors.white),
                          //       )
                          //     : Text("Set Location",
                          //         style: TextStyle(
                          //           fontSize: 20,
                          //         )),
                          label: Text(
                            "Set Location",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF404040),
                            foregroundColor: Color.fromRGBO(236, 183, 43, 1),
                            fixedSize: Size(180, 50),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(160, 10, 30, 20),
                        child: ElevatedButton(
                          // onPressed: () {},
                          onPressed: isLoading ? null : () => _SignUp(),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text("Sign up",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFECB72B),
                            foregroundColor: Color(0xFF404040),
                            fixedSize: Size(400, 50),
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                        child: Row(children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(color: Color(0xFF404040)),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => sign_in_customer(),
                                    ));
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(color: Color(0xFFECB72B)),
                              ))
                        ]),
                      ),
                    ],
                  ),
                )));
  }
}
