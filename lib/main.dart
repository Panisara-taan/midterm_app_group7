import 'package:flutter/material.dart';
import 'package:pobpad/fifth_page.dart';
import 'package:pobpad/first_page.dart';
import 'package:pobpad/activity_history_page.dart';
import 'package:pobpad/second_page.dart';
import 'package:pobpad/signin_page.dart';
import 'package:pobpad/sixth_page.dart';
import 'package:pobpad/activity_page.dart';
import 'package:provider/provider.dart';
import 'path/to/activity_model.dart'; // Ensure you include the correct path

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivityModel()), 
        // Add other providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Me',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 197, 130, 110),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/1',
      routes: {
        '/0': (context) => SigninPage(title: ''),
        '/1': (context) => FirstPage(),
        '/2': (context) => SecondPage(),
        '/3': (context) => ThirdPage(),
        '/4': (context) => FourthPage(),
        '/5': (context) => FifthPage(),
        '/6': (context) => SixthPage(),
        // Add additional routes if necessary
      },
    );
  }
}
