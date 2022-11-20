import 'package:flutter/material.dart';
import 'package:flutter_sqflite/page/add_students_page.dart';
import 'package:flutter_sqflite/page/list_students_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sqlite and Sqflite"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  // return AddStudent();
                  return const AddStudentPage();
                }));
              },
              child: const Text("Add Student"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ListStudentsPage();
                }));
              },
              child: const Text("List Student Record"),
            ),
          ],
        ),
      ),
    );
  }
}
