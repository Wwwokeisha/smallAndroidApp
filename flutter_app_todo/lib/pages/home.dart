import 'package:flutter/material.dart';
import 'package:flutter_app_todo/widgets/ModifyText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _userCurrentValue = '';

  void _removeElement(String idx) {
    FirebaseFirestore.instance
          .collection('items')
          .doc(idx).delete();
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
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
      FirebaseFirestore.instance
          .collection('items')
          .add({'task': _userCurrentValue});

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const ModifyText('Нет записей');
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: ModifyText(snapshot.data!.docs[index].get('task')),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_sweep,
                            color: Theme.of(context).primaryColor),
                        onPressed: () {
                          _removeElement(snapshot.data!.docs[index].id);
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    _removeElement(snapshot.data!.docs[index].id);
                  },
                );
              });
        },
      ),
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
