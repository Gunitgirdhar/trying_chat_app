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
    apiKey: 'AIzaSyCWhTnpPOPKi5a6yHphEaSkTkU-pr-nEvI',
    appId: '1:1085342532706:web:2993b056412ed4f247fd3b',
    messagingSenderId: '1085342532706',
    projectId: 'wechat-aab2b',
    authDomain: 'wechat-aab2b.firebaseapp.com',
    storageBucket: 'wechat-aab2b.appspot.com',
    measurementId: 'G-ZQ8XQSV0RM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-5goV2wmgBMryMND0Hxyp1buFChWKsv4',
    appId: '1:1085342532706:android:bab3f0c8866e755e47fd3b',
    messagingSenderId: '1085342532706',
    projectId: 'wechat-aab2b',
    storageBucket: 'wechat-aab2b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMsGHhIXCJjId2PXcv0S0de-KYFDLP5OI',
    appId: '1:1085342532706:ios:b58386e0e3199acd47fd3b',
    messagingSenderId: '1085342532706',
    projectId: 'wechat-aab2b',
    storageBucket: 'wechat-aab2b.appspot.com',
    iosBundleId: 'com.example.tryingChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMsGHhIXCJjId2PXcv0S0de-KYFDLP5OI',
    appId: '1:1085342532706:ios:b58386e0e3199acd47fd3b',
    messagingSenderId: '1085342532706',
    projectId: 'wechat-aab2b',
    storageBucket: 'wechat-aab2b.appspot.com',
    iosBundleId: 'com.example.tryingChatApp',
  );
}
