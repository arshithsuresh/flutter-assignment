import 'package:flutter/material.dart';
import 'package:todoapp/model/todoModel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDoModel> todoList = [];

  final todoTitleFieldController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _collection = FirebaseFirestore.instance.collection("todolist");

  void deleteTask(ToDoModel item) {
    _collection.doc(item.documentId).delete();
  }

  void setTaskStatus(ToDoModel item) {
    _collection.doc(item.documentId).update({"status": !item.getStatus()});
  }

  void deleteAllTasks() {
    _collection.limit(50).get().then((value) => value.docs.every((element) {
          _collection.doc(element.id).delete();
          return true;
        }));
  }

  void createNewTask() {
    ToDoModel newTask = ToDoModel(title: todoTitleFieldController.text);

    _collection.add(newTask.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Checklist"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              color: Colors.white,
              onPressed: () {
                deleteAllTasks();
              })
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              "My ToDo List",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black87),
            ),
            SizedBox(height: 30),
            TextField(
              controller: todoTitleFieldController,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  hintText: '  Add a task...',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        width: 2,
                      ))),
            ),
            SizedBox(height: 8),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  createNewTask();
                },
                child: Text(" Add ")),
            SizedBox(
              height: 8,
            ),
            Container(
                decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1, color: Colors.teal)),
            )),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: _firestore.collection("todolist").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                          child: Text("No Tasks Found!",
                              style: TextStyle(
                                  fontSize: 23, color: Colors.blueGrey)));

                    QuerySnapshot data = snapshot.data;

                    return ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          ToDoModel item = ToDoModel.fromJson(
                              data.docs[index].data(), data.docs[index].id);
                          return todoContainer(item);
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget todoContainer(ToDoModel item) {
    IconData statusIcon =
        item.getStatus() ? Icons.done : Icons.radio_button_unchecked;
    return Container(
        margin: EdgeInsets.only(top: 4, bottom: 4),
        padding: EdgeInsets.only(left: 6, right: 12, top: 4, bottom: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(32)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(statusIcon),
                color: Colors.blueGrey,
                onPressed: () {
                  setTaskStatus(item);
                }),
            Text(item.getTitle(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.blueGrey,
                    decoration: item.getStatus()
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            IconButton(
                icon: Icon(Icons.delete),
                color: Colors.blueGrey,
                onPressed: () {
                  deleteTask(item);
                })
          ],
        ));
  }
}
