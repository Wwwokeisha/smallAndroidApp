import 'package:flutter/material.dart';
import 'package:flutter_app_todo/pages/home.dart';
import 'package:flutter_app_todo/pages/main_screen.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Osward',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/todo': (context) => const Home(),
      },
    ));
