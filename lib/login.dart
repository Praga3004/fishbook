import "package:flutter/material.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login Page",style: TextStyle(color: Colors.blue),),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.email),prefixIconColor: Colors.grey,focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(10) ),
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
                    decoration: InputDecoration(
                      labelText: "Password",labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.lock),prefixIconColor: Colors.grey,
                      filled: true,
                      fillColor: Colors.white,focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ), SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print("Pressed");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          Text(
                            'Submit',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                    );
                  },
                ),
               overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.focused)) {
                      return Colors.white.withOpacity(0.2); // Overlay color when touched
                    }
                    return Colors.blue.withOpacity(0.2); // Default overlay color
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
