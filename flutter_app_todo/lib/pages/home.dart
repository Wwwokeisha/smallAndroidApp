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

    todoList.addAll(['Buy milk', 'Купить снеки', 'BEEERR ']);
  }

  void removeElement(int idx) {
    setState(() {
      todoList.removeAt(idx);
    });
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
                      removeElement(index);
                    },
                  ),
                ),
              ),
              onDismissed: (direction) {
                removeElement(index);
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
                      onPressed: () {
                        setState(() {
                          todoList.add(_userCurrentValue);
                        });

                        Navigator.of(context).pop();
                        _userCurrentValue = '';
                      }, 
                      child: const ModifyText('Добавить')
                    )
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
