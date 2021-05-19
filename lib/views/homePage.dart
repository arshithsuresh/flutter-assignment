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
    _collection.doc(item.documentId).update({
        "status" : !item.getStatus()
    });
  }

  void deleteAllTasks() {
    _collection.limit(50).get().then((value) => value.docs.every((element){
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
        title: Text("TodoList"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
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
              "ToDo List",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 20),
            Text("Title"),
            TextField(
              controller: todoTitleFieldController,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(width: 2))),
            ),
            SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  createNewTask();
                },
                child: Text(" Add ")),
            SizedBox(
              height: 8,
            ),
            Container(
                decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1, color: Colors.grey)),
            )),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: StreamBuilder(
                stream: _firestore.collection("todolist").snapshots(),
                builder: (context, snapshot) {

                  

                  if(!snapshot.hasData)
                    return Center(
                      child: Text("No Tasks Found!"),
                    );

                  QuerySnapshot data = snapshot.data;

                  return ListView.builder
                  (
                    itemCount: data.docs.length,
                    itemBuilder: (context,index){
                        ToDoModel item = ToDoModel.fromJson(data.docs[index].data(), data.docs[index].id);
                        return todoContainer(item);
                  });
                }
              ),
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
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(32)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(statusIcon),
                onPressed: () {
                  setTaskStatus(item);
                }),
            Text(item.getTitle(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    decoration: item.getStatus()
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteTask(item);
                })
          ],
        ));
  }
}
