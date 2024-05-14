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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBQ7-RspnOMdpV7q7isjXwUum-rKfb5Tus',
    appId: '1:748125996732:web:d3d3023fc6024bf784f2b9',
    messagingSenderId: '748125996732',
    projectId: 'izhiman-dictionary',
    authDomain: 'izhiman-dictionary.firebaseapp.com',
    databaseURL: 'https://izhiman-dictionary-default-rtdb.firebaseio.com',
    storageBucket: 'izhiman-dictionary.appspot.com',
    measurementId: 'G-YGCDS1MHKN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDq7KCvDyNtaSs7PBflF7V_gsqB0-96rzw',
    appId: '1:748125996732:android:ab988d744ec94c5184f2b9',
    messagingSenderId: '748125996732',
    projectId: 'izhiman-dictionary',
    databaseURL: 'https://izhiman-dictionary-default-rtdb.firebaseio.com',
    storageBucket: 'izhiman-dictionary.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCc_m92NNT8I3RyCGF1ZuWEooyMORQG8w8',
    appId: '1:748125996732:ios:2b6c573f890b5aeb84f2b9',
    messagingSenderId: '748125996732',
    projectId: 'izhiman-dictionary',
    databaseURL: 'https://izhiman-dictionary-default-rtdb.firebaseio.com',
    storageBucket: 'izhiman-dictionary.appspot.com',
    iosBundleId: 'com.izhiman.izhimanDic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCc_m92NNT8I3RyCGF1ZuWEooyMORQG8w8',
    appId: '1:748125996732:ios:2b6c573f890b5aeb84f2b9',
    messagingSenderId: '748125996732',
    projectId: 'izhiman-dictionary',
    databaseURL: 'https://izhiman-dictionary-default-rtdb.firebaseio.com',
    storageBucket: 'izhiman-dictionary.appspot.com',
    iosBundleId: 'com.izhiman.izhimanDic',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBQ7-RspnOMdpV7q7isjXwUum-rKfb5Tus',
    appId: '1:748125996732:web:b472520045b1a6a184f2b9',
    messagingSenderId: '748125996732',
    projectId: 'izhiman-dictionary',
    authDomain: 'izhiman-dictionary.firebaseapp.com',
    databaseURL: 'https://izhiman-dictionary-default-rtdb.firebaseio.com',
    storageBucket: 'izhiman-dictionary.appspot.com',
    measurementId: 'G-JDLNKV3BXK',
  );
}