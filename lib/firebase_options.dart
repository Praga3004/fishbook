// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD1qUS67_hvYVA_ymqOt0OuD5Q0I1_WfIY',
    appId: '1:946256318755:web:4fa57da828682cca3b7c96',
    messagingSenderId: '946256318755',
    projectId: 'fishbook-e6ae1',
    authDomain: 'fishbook-e6ae1.firebaseapp.com',
    databaseURL: 'https://fishbook-e6ae1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fishbook-e6ae1.appspot.com',
    measurementId: 'G-32M6YKN1FB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDenrSqATW6Mv3SW9FvaQTd4SagFjRAXtc',
    appId: '1:946256318755:android:9f72da70e268ef813b7c96',
    messagingSenderId: '946256318755',
    projectId: 'fishbook-e6ae1',
    databaseURL: 'https://fishbook-e6ae1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fishbook-e6ae1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIDdHSQ1AZB1Cqn7u_X3P3QXeCmfV9EXg',
    appId: '1:946256318755:ios:1de5d8e77a7a45673b7c96',
    messagingSenderId: '946256318755',
    projectId: 'fishbook-e6ae1',
    databaseURL: 'https://fishbook-e6ae1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fishbook-e6ae1.appspot.com',
    iosBundleId: 'com.example.fishbook',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCIDdHSQ1AZB1Cqn7u_X3P3QXeCmfV9EXg',
    appId: '1:946256318755:ios:b10bf3b34a9a5ebd3b7c96',
    messagingSenderId: '946256318755',
    projectId: 'fishbook-e6ae1',
    databaseURL: 'https://fishbook-e6ae1-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fishbook-e6ae1.appspot.com',
    iosBundleId: 'com.example.fishbook.RunnerTests',
  );
}
