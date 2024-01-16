import 'package:fishbook/main.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordVisible=true;
  FireStoreService fs = new FireStoreService();
  TextEditingController eCon = new TextEditingController();
  TextEditingController pCon = new TextEditingController();
  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((userCrediential) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "Navigated")));
      });
    } catch (e) {
      fs.showWarningDialog(context, "Sign In Error", e.toString());
    }
  }

  bool isEmailValid(String email) {
    // Regular expression for a valid email address
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  String emailWarning = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login Page",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: TextField(
                    controller: eCon,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextField(
                    controller: pCon,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _isPasswordVisible,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: Colors.grey,
                        filled: true,
                        fillColor: Colors.white, suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(_isPasswordVisible?Icons.visibility:Icons.visibility_off)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String email = eCon.text;
                      String pass = pCon.text;
                      if (!isEmailValid(email)) {
                        setState(() {
                          emailWarning = 'Invalid email address';
                        });
                        return;
                      } else {
                        setState(() {
                          emailWarning = '';
                        });
                      }

                      signIn(email, pass);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Submit',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the value as needed
                          );
                        },
                      ),
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.white
                                .withOpacity(0.2); // Overlay color when touched
                          }
                          return Colors.blue
                              .withOpacity(0.2); // Default overlay color
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
