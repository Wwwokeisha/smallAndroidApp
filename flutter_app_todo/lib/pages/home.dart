import 'package:flutter/material.dart';
import 'package:flutter_app_todo/widgets/ModifyText.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _userCurrentValue = '';
  List todoList = [];

  @override
  void initState() {
    super.initState();

    todoList.addAll(['Buy milk', 'Купить снеки']);
  }

  void _removeElement(int idx) {
    setState(() {
      todoList.removeAt(idx);
    });
  }

  void _menuOpen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.amber[100],
        appBar: AppBar(
          title: const Text('Меню',
              style: TextStyle(
                fontFamily: 'Oswald',
                color: Colors.white,
              )),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                child: const ModifyText('На главную!')),
          ],
        ),
      );
    }));
  }

  void addTask() {
    if (_userCurrentValue == '') {
      Navigator.of(context).pop();
    } else {
      setState(() {
        todoList.add(_userCurrentValue);
      });

      Navigator.of(context).pop();
      _userCurrentValue = '';
    }
  }

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
        actions: [
          IconButton(
            onPressed: _menuOpen,
            icon: Icon(Icons.menu_open_sharp),
            color: Colors.white,
          )
        ],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(todoList[index]),
              child: Card(
                child: ListTile(
                  title: ModifyText(todoList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_sweep,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      _removeElement(index);
                    },
                  ),
                ),
              ),
              onDismissed: (direction) {
                _removeElement(index);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const ModifyText('Добавить задачу'),
                  content: TextField(
                    onChanged: (String value) {
                      _userCurrentValue = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: addTask, child: const ModifyText('Добавить'))
                  ],
                );
              });
        },
        mini: true,
        child: Icon(
          Icons.add_chart_rounded,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
