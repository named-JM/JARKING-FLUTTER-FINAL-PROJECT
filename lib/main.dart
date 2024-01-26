import 'package:final_project_for_flutter_by_jarling/firebase_options.dart';
import 'package:final_project_for_flutter_by_jarling/splashArt.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized
  //Configures the system UI overlay style, setting the system navigation bar color and the status bar color.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.grey[900],
    statusBarColor: Colors.transparent,
  ));
  /*This ensures that the correct Firebase configuration is used for the platform on which the application is running. */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashArt(),
    );
  }
}
