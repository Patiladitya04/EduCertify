import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCmNxIwWcR1RV5S8NgeaajVziGnSCsUg_s',
    appId: '1:778435851414:web:f1e8477636160256317eb7',
    messagingSenderId: '778435851414',
    projectId: 'educertify-f371e',
    authDomain: 'educertify-f371e.firebaseapp.com',
    storageBucket: 'educertify-f371e.firebasestorage.app',
    measurementId: 'G-SZLVQMX5PQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNtVVbK6ENe4Yhn9AnIE4yX_VUre0tvTQ',
    appId: '1:778435851414:android:e395b55ba1510913317eb7',
    messagingSenderId: '778435851414',
    projectId: 'educertify-f371e',
    storageBucket: 'educertify-f371e.firebasestorage.app',
    androidClientId: 'YOUR_ANDROID_CLIENT_ID',
    androidPackage: 'com.educertify.app',
  );
}
