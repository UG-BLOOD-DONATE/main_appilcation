import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/first_screens/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
<<<<<<< Updated upstream
  runApp(MaterialApp(home: Splash()));
}
=======
  runApp(MaterialApp(
      home: Splash(),

      /// Register RouteObserver
      navigatorObservers: [routeObserver],

      /// Define the app routes
      initialRoute: '/',
      routes: {
        '/profile': (context) => ProfilePage(),
      }));
}

/// Register RouteObserver
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
>>>>>>> Stashed changes
