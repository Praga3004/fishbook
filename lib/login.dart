import 'package:fishbook/main.dart';
import 'package:fishbook/startup.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordVisible = true;
  FireStoreService fs = new FireStoreService();
  TextEditingController eCon = new TextEditingController();
  TextEditingController pCon = new TextEditingController();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      GoogleSignInAuthentication googleauth = await googleUser.authentication;
      AuthCredential cred = GoogleAuthProvider.credential(
          accessToken: googleauth.accessToken, idToken: googleauth.idToken);

      return await FirebaseAuth.instance.signInWithCredential(cred);
    } catch (e) {
      print("Error with google sign in: $e");
      return null;
    }
  }

   Future<void> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // After successful login, set the token in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', 'someNonNullableValue');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  } catch (e) {
    fs.showWarningDialog(context, "Sign In Error", e.toString());
  }
}


  void resetPassword(String enteredEmail) async {
    try {
      print(enteredEmail);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: enteredEmail);
      // Display a message to the user indicating that a password reset email has been sent.
      fs.showWarningDialog(
          context, "Reset mail sent successfully", "to your $enteredEmail");
    } catch (e) {
      // Handle errors, e.g., if the email address is not registered.
      fs.showWarningDialog(context, "Error sending reset mail", e.toString());
    }
  }

  bool isEmailValid(String email) {
    // Regular expression for a valid email address
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    // Regular expression for a password with special character, digits, and alphabets
    String passwordRegex =
        r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(passwordRegex);
    return regex.hasMatch(password);
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/zoro.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
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
                  ),
                  Text(emailWarning, style: TextStyle(color: Colors.red)),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
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
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(_isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10))),
                      ),
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
                            emailWarning = email == ''
                                ? 'Email Required'
                                : 'Invalid email address';
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
                        fixedSize: MaterialStateProperty.all(Size(150.0, 50.0)),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
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
                              return Colors.white.withOpacity(
                                  0.2); // Overlay color when touched
                            }
                            return Colors.blue
                                .withOpacity(0.2); // Default overlay color
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(200.0, 50.0)),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the value as needed
                              );
                            },
                          ),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return Colors.white.withOpacity(
                                    0.2); // Overlay color when touched
                              }
                              return Colors.blue
                                  .withOpacity(0.2); // Default overlay color
                            },
                          ),
                        ),
                        onPressed: () {
                          String email = eCon.text;
                          if (!isEmailValid(email)) {
                            emailWarning = email == ''
                                ? 'Email required'
                                : 'Invalid Email';
                            return;
                          }
                          resetPassword(email);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    Size(double.infinity, 60.0)),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (Set<MaterialState> states) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the value as needed
                                    );
                                  },
                                ),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.focused)) {
                                      return Colors.white.withOpacity(
                                          0.2); // Overlay color when touched
                                    }
                                    return Colors.blue.withOpacity(
                                        0.2); // Default overlay color
                                  },
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Sign Up?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              )),
                        ),
                        Expanded(
                          child: TextButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    Size(double.infinity, 60.0)),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (Set<MaterialState> states) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the value as needed
                                    );
                                  },
                                ),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.focused)) {
                                      return Colors.white.withOpacity(
                                          0.2); // Overlay color when touched
                                    }
                                    return Colors.blue.withOpacity(
                                        0.2); // Default overlay color
                                  },
                                ),
                              ),
                              onPressed: () async {
                                UserCredential? userCredential =
                                    await signInWithGoogle();

                                if (userCredential != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage()));
                                  print(
                                      "Successfully signed in with Google: ${userCredential.user!.displayName}");
                                } else {
                                  print("Google Sign-In failed");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Sign up with google",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
