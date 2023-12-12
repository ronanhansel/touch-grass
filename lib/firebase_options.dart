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
    apiKey: 'AIzaSyDb4DZDANLdrwxwTnCQa3xQEDEIolpmLL4',
    appId: '1:946035220692:web:3f1a5503a0ff07f9025b41',
    messagingSenderId: '946035220692',
    projectId: 'touch-grass-3ab53',
    authDomain: 'touch-grass-3ab53.firebaseapp.com',
    storageBucket: 'touch-grass-3ab53.appspot.com',
    measurementId: 'G-EZCBEDY996',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcvvKa2uGy3c_UvbqJL-_tFEG9KzDTzfs',
    appId: '1:946035220692:android:58f2b5e91d6f71f3025b41',
    messagingSenderId: '946035220692',
    projectId: 'touch-grass-3ab53',
    storageBucket: 'touch-grass-3ab53.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCX_ngPp7gTfVwOwThpIg01a1Eetitg-l4',
    appId: '1:946035220692:ios:5111521000c92d3d025b41',
    messagingSenderId: '946035220692',
    projectId: 'touch-grass-3ab53',
    storageBucket: 'touch-grass-3ab53.appspot.com',
    iosClientId: '946035220692-cfis9fiivauaotdr3uts460lcdsfn97u.apps.googleusercontent.com',
    iosBundleId: 'com.testing.gdscSolution',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCX_ngPp7gTfVwOwThpIg01a1Eetitg-l4',
    appId: '1:946035220692:ios:d5dd90ef78f3cffc025b41',
    messagingSenderId: '946035220692',
    projectId: 'touch-grass-3ab53',
    storageBucket: 'touch-grass-3ab53.appspot.com',
    iosClientId: '946035220692-mmj98r5mimo0c2vherjfq3jhig1riq37.apps.googleusercontent.com',
    iosBundleId: 'com.example.gdscSolution.RunnerTests',
  );
}
