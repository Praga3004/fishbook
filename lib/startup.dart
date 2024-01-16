import 'package:fishbook/login.dart';
import 'package:fishbook/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FireStoreService fs = new FireStoreService();

  double calculateFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return screenWidth / 30;
  }

  bool _isPasswordVisible = true;
  bool user_type = true;
  TextEditingController uCon = TextEditingController();
  TextEditingController eCon = TextEditingController();
  TextEditingController pCon = TextEditingController();
  TextEditingController paCon = TextEditingController();
  TextEditingController cpCon = TextEditingController();
  Future<void> addDataToFirestore() async {
    try {
      String email = eCon.text;
      fs.addData(
          'user',
          {
            'user_type': user_type,
            'user': uCon.text,
            'email': eCon.text,
            'phone': (pCon.text),
          },
          documentId: email);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: paCon.text,
      )
          .then((userCrediential) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
      uCon.text = '';
      eCon.text = '';
      pCon.text = '';
      paCon.text = '';
      cpCon.text = '';

      print('Data added successfully');
    } catch (e) {
      fs.showWarningDialog(context, "Sign Up Error", e.toString());
    }
  }

  bool isEmailValid(String email) {
    // Regular expression for a valid email address
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  bool isPhoneNumberValid(String phone) {
    // Regular expression for a valid 10-digit phone number
    String phoneRegex = r'^\d{10}$';
    RegExp regex = RegExp(phoneRegex);
    return regex.hasMatch(phone);
  }

  bool isPasswordValid(String password) {
    // Regular expression for a password with special character, digits, and alphabets
    String passwordRegex =
        r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(passwordRegex);
    return regex.hasMatch(password);
  }

  String emailWarning = '';
  String phoneWarning = '';
  String passwordWarning = '';
  String confirmPasswordWarning = '';

  @override
  Widget build(BuildContext context) {
    double FontSize = calculateFontSize(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SignUp'),
        ),
        body: SingleChildScrollView(
          // Wrap the content in a SingleChildScrollView
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/zoro.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                        child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Color.fromARGB(255, 109, 2, 141),
                          fontSize: FontSize,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  user_type = true;
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    size: 50,
                                    color: user_type
                                        ? Colors.white
                                        : Colors.purple,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Owner',
                                    style: TextStyle(
                                        color: user_type
                                            ? Colors.white
                                            : Colors.purple),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: EdgeInsets.all(30.0),
                                  minimumSize: Size(100, 100),
                                  backgroundColor:
                                      user_type ? Colors.purple : Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  user_type = false;
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    color: user_type
                                        ? Colors.purple
                                        : Colors.white,
                                    size: 50,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Crew Member',
                                    style: TextStyle(
                                        color: user_type
                                            ? Colors.purple
                                            : Colors.white),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: EdgeInsets.all(30.0),
                                  minimumSize: Size(100, 100),
                                  backgroundColor:
                                      user_type ? Colors.white : Colors.purple),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 10.0),
                  Column(
                    children: [
                      TextField(
                        controller: uCon,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(''),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Column(
                    children: [
                      TextField(
                        controller: eCon,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(emailWarning, style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Column(
                    children: [
                      TextField(
                        controller: pCon,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone No.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.phone_in_talk),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(phoneWarning, style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Column(
                    children: [
                      TextField(
                        controller: paCon,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isPasswordVisible,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(_isPasswordVisible?Icons.visibility:Icons.visibility_off))),
                      ),
                      SizedBox(height: 5),
                      Text(passwordWarning,
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Column(
                    children: [
                      TextField(
                        controller: cpCon,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        confirmPasswordWarning,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        String username = uCon.text;
                        String email = eCon.text;
                        String phone = pCon.text;
                        String password = paCon.text;
                        String confirmPassword = cpCon.text;
                        String user = user_type ? "Owner" : "Crew Member";

                        // Validate email
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

                        // Validate phone number
                        if (!isPhoneNumberValid(phone)) {
                          setState(() {
                            phoneWarning = 'Invalid phone number';
                          });
                          return;
                        } else {
                          setState(() {
                            phoneWarning = '';
                          });
                        }

                        // Validate password
                        if (!isPasswordValid(password)) {
                          setState(() {
                            passwordWarning = 'Invalid password';
                          });
                          return;
                        } else {
                          setState(() {
                            passwordWarning = '';
                          });
                        }

                        // Check if password and confirm password match
                        if (password != confirmPassword) {
                          setState(() {
                            confirmPasswordWarning =
                                'Password and Confirm Password do not match';
                          });
                          return;
                        } else {
                          setState(() {
                            confirmPasswordWarning = '';
                          });
                        }
                        print(passwordWarning);
                        // All validations passed, print or use the values as needed
                        addDataToFirestore();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(width: 8.0),
                          Text(
                            'Submit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: EdgeInsets.all(30.0),
                          minimumSize: Size(50, 50)),
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
