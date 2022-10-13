import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/Doctor_side/screen/blood_page.dart';
import '../firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: Request_page()));
}
