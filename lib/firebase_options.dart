// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBAa0XHHJHYb974U1Np9paDN023EX4r_nc',
    appId: '1:345406840514:web:1dda9418527cc39aed255b',
    messagingSenderId: '345406840514',
    projectId: 'qr-app-meril',
    authDomain: 'qr-app-meril.firebaseapp.com',
    storageBucket: 'qr-app-meril.firebasestorage.app',
    measurementId: 'G-YSGC75LTQC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8cJz-SjeDI-Z-OUQZmBDkd2j1WcIyTgA',
    appId: '1:345406840514:android:d0a2d65011b8cf4ced255b',
    messagingSenderId: '345406840514',
    projectId: 'qr-app-meril',
    storageBucket: 'qr-app-meril.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3ugBNiPeD0gBpb-TMI2A0_HHvPC9aRow',
    appId: '1:345406840514:ios:ad4025e28b8daa9aed255b',
    messagingSenderId: '345406840514',
    projectId: 'qr-app-meril',
    storageBucket: 'qr-app-meril.firebasestorage.app',
    iosBundleId: 'com.example.myapp',
  );
}
