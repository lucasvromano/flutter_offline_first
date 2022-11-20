import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/db.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPage();
}

class _AddStudentPage extends State<AddStudentPage> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();

  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                hintText: "Stuent Name",
              ),
            ),
            TextField(
              controller: rollno,
              decoration: const InputDecoration(
                hintText: "Roll No.",
              ),
            ),
            TextField(
              controller: address,
              decoration: const InputDecoration(
                hintText: "Address:",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                mydb.db.rawInsert(
                    "INSERT INTO students (name, roll_no, address) VALUES (?, ?, ?);",
                    [
                      name.text,
                      rollno.text,
                      address.text
                    ]); //add student from form to database

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("New Student Added")));
                //show snackbar message after adding student

                name.text = "";
                rollno.text = "";
                address.text = "";
                //clear form to empty after adding data
              },
              child: const Text("Save Student Data"),
            ),
          ],
        ),
      ),
    );
  }
}
