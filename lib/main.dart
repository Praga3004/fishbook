import 'package:fishbook/login.dart';
import 'package:fishbook/owenerdetails.dart';
import 'package:fishbook/startup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'BottonNavigationBarMixin.dart';
import 'CustomAppBarMixin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.transparent,
            hoverColor: Colors.blue.withOpacity(0.5),
            elevation: 0.0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
          ),
        ),
      ),
      home: SignUp(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with BottomNavigationBarMixin, CustomAppBarMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _currentIndex = 0;
  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('user').doc(user.email).get();

      if (userSnapshot.exists) {
        setState(() {
          _user = user;
          _userData = userSnapshot.data() as Map<String, dynamic>;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppbar(context),
      drawer: LeftDashboard(),
      body: Center(
        child: _user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User Details:'),
                  Text('User ID: ${_user!.uid}'),
                  Text('UserName:${_user!.displayName}'),
                  Text('Phone:${_userData?['phoneNumber']}'),
                  Text('Email: ${_user!.email}'),
                  Text('UserType:${_userData?['userType']}'),
                ],
              )
            : CircularProgressIndicator(),
      ),
      bottomNavigationBar:
          buildBottomNavigationBar(context, _currentIndex, (index) {
        setState(() {
          _currentIndex = index;
          navigateToPage(context, index);
        });
      }),
    );
  }

  AppBar buildCustomAppbar(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.dashboard,
              size: 30,
              color: Colors.lightBlue,
            ),
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            print("Right Button");
          },
          icon: Icon(
            Icons.person,
            size: 30.0,
            color: Colors.lightBlue,
          ),
        ),
      ],
    );
  }
}

class LeftDashboard extends StatelessWidget {
  MyHomePage hm = new MyHomePage();
  FireStoreService fs = new FireStoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  bool user_type = false;
  Map<String, dynamic>? _userData;

  Future<void> isowner(BuildContext context) async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('user').doc(user.email).get();

      if (userSnapshot.exists) {
      
          _user = user;
          _userData = userSnapshot.data() as Map<String, dynamic>;
        

       
      }
    }
    print(_userData?['userType']);
    if (_userData != null) {
      user_type = _userData?['userType'] == "Crew member" ? false : true;
      print(user_type);
      if (user_type) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Owner()),
        );
      } else {
        fs.showWarningDialog(
          context,
          "Restricted",
          "You Don't have Permission",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  isowner(context);
                },
                child: Text("Owner Details",
                    style: TextStyle(color: Colors.white)),
              ),
              onTap: () {},
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  print("Item 1");
                },
                child: Text("Transactions",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              onTap: () {},
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  print("Item 1");
                },
                child: Text("Work Management",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              onTap: () {},
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  print("Item 1");
                },
                child: Text("Payment",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              onTap: () {},
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  print("Item 1");
                },
                child: Text("Settings",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class FireStoreService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FireStoreService _instance = FireStoreService._internal();
  factory FireStoreService() => _instance;
  FireStoreService._internal();
  void showWarningDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> addData(String collection, Map<String, dynamic> data,
      {String? documentId}) async {
    CollectionReference col = _firestore.collection(collection);
    DocumentReference documentReference =
        documentId != null ? col.doc(documentId) : await col.add(data);
    documentReference.set(data);
  }
}
