import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/first_screens/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: Splash()));
}
