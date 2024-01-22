import 'package:flutter/material.dart';
import 'package:flutter_app_todo/pages/home.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Osward',
      ),
      home: Home(),
    ));
