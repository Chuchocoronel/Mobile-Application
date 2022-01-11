import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/main_menu_screen.dart';
import 'package:mobileapp/widgets/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AuthGate(app: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}
