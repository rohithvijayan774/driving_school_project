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
    apiKey: 'AIzaSyC8jZgxvkdLmU3-OxEbW_kwXel5jSMLvFk',
    appId: '1:1094031484275:web:c9a4323db09b30f98fd106',
    messagingSenderId: '1094031484275',
    projectId: 'drivingschool-646e1',
    authDomain: 'drivingschool-646e1.firebaseapp.com',
    storageBucket: 'drivingschool-646e1.appspot.com',
    measurementId: 'G-4W2QXMEP1W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXFa-fHYOZHyoooVjzGX72nYAVaS-XUH0',
    appId: '1:1094031484275:android:09b2eeaf522a56c58fd106',
    messagingSenderId: '1094031484275',
    projectId: 'drivingschool-646e1',
    storageBucket: 'drivingschool-646e1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIxN1fuwpu05mXlf-vHrNZ3Us-8kpnP64',
    appId: '1:1094031484275:ios:cf454ae1fb82308f8fd106',
    messagingSenderId: '1094031484275',
    projectId: 'drivingschool-646e1',
    storageBucket: 'drivingschool-646e1.appspot.com',
    iosBundleId: 'com.example.drivingSchool',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBIxN1fuwpu05mXlf-vHrNZ3Us-8kpnP64',
    appId: '1:1094031484275:ios:6a03fa992b610d668fd106',
    messagingSenderId: '1094031484275',
    projectId: 'drivingschool-646e1',
    storageBucket: 'drivingschool-646e1.appspot.com',
    iosBundleId: 'com.example.drivingSchool.RunnerTests',
  );
}
