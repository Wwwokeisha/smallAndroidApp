import 'package:flutter/material.dart';
import 'package:flutter_app_todo/widgets/ModifyText.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[100],
        appBar: AppBar(
          title: const Text('Текущий список дел',
              style: TextStyle(
                fontFamily: 'Oswald',
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(
          children: [
            const ModifyText('Главная страница'),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/todo');
                },
                child: const ModifyText('Перейти далее'))
          ],
        ));
  }
}
