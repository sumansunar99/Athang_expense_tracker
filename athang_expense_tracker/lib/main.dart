import 'package:athang_expense_tracker/plugins/firebase_api.dart';
import 'package:athang_expense_tracker/plugins/local_notifications.dart';
import 'package:athang_expense_tracker/screens/Temp_screen.dart';
import 'package:athang_expense_tracker/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'plugins/local_shared_preferences.dart';
import 'screens/common/temp_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      // home: TempScreen(),
      // home: HomeLayout(),
    );
  }
}
