import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/db.dart';

class EditStudentPage extends StatefulWidget {
  int rollno;
  EditStudentPage({Key? key, required this.rollno}) : super(key: key);

  @override
  State<EditStudentPage> createState() => _EditStudentPage();
}

class _EditStudentPage extends State<EditStudentPage> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();

  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();

    Future.delayed(const Duration(milliseconds: 500), () async {
      var data = await mydb.getStudent(
          widget.rollno); //widget.rollno is passed paramater to this class
      if (data != null) {
        name.text = data["name"];
        rollno.text = data["roll_no"].toString();
        address.text = data["address"];
        setState(() {});
      } else {
        print("No any data with roll no: " + widget.rollno.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Student"),
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
                    "UPDATE students SET name = ?, roll_no = ?, address = ? WHERE roll_no = ?",
                    [name.text, rollno.text, address.text, widget.rollno]);
                //update table with roll no.
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Student Data Updated")));
              },
              child: const Text("Update Student Data"),
            ),
          ],
        ),
      ),
    );
  }
}
