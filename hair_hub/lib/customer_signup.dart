// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_final_fields
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'sign_in.dart';
import 'auth_services.dart';
import 'customer_signin.dart';

class sign_up2 extends StatefulWidget {
  const sign_up2({super.key});

  @override
  State<sign_up2> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up2> {
  bool _obscuretext = true;
  bool isLoading = false;
  TextEditingController email_c = TextEditingController();
  TextEditingController password_c = TextEditingController();
  TextEditingController name_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> _SignUp() async {
      // Simulating the data sending process
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 3));
      AuthService().signUp(name_c.text, email_c.text, password_c.text, context);

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
                            Text("Name",
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
                                controller: name_c,
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
                        padding: EdgeInsets.fromLTRB(120, 0, 0, 0),
                        child: Row(children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                                fontSize: 15, color: Color(0xFF404040)),
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
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xFFECB72B)),
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
                            Text("Name",
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
                                controller: name_c,
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
                        padding: EdgeInsets.fromLTRB(180, 10, 30, 20),
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
                            style: TextStyle(
                                fontSize: 15, color: Color(0xFF404040)),
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
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xFFECB72B)),
                              ))
                        ]),
                      ),
                    ],
                  ),
                )));
  }
}
