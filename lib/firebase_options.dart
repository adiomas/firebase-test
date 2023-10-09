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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDwhIahXI6KGMOK1v3OIcJDZpVUnb4ihcc',
    appId: '1:912234698899:web:2b31411ce207bb203a1566',
    messagingSenderId: '912234698899',
    projectId: 'fir-test-511c0',
    authDomain: 'fir-test-511c0.firebaseapp.com',
    storageBucket: 'fir-test-511c0.appspot.com',
    measurementId: 'G-DGCLSDT3WT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVzijF-IWayGGymuGzMDSf2caHqxWoP8Q',
    appId: '1:912234698899:android:e1ff163080bedd9d3a1566',
    messagingSenderId: '912234698899',
    projectId: 'fir-test-511c0',
    storageBucket: 'fir-test-511c0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBep6wK2SMT2LvdJrFkLRNGYtAKcFtgBig',
    appId: '1:912234698899:ios:cf3fc066160df8303a1566',
    messagingSenderId: '912234698899',
    projectId: 'fir-test-511c0',
    storageBucket: 'fir-test-511c0.appspot.com',
    iosBundleId: 'com.example.firebaseTest.staging',
  );
}
