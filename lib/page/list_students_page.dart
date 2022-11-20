import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/db.dart';
import 'package:flutter_sqflite/page/edit_student_page.dart';

class ListStudentsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListStudentsPage();
  }
}

class _ListStudentsPage extends State<ListStudentsPage> {
  List<Map> slist = [];
  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      //use delay min 500 ms, because database takes time to initilize.
      slist = await mydb.db.rawQuery('SELECT * FROM students');

      setState(() {}); //refresh UI after getting data from table.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Students"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.isEmpty
              ? const Text("No any students to show.")
              : //show message if there is no any student
              Column(
                  //or populate list to Column children if there is student data.
                  children: slist.map(
                    (stuone) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.people),
                          title: Text(stuone["name"]),
                          subtitle: Text(
                              'Roll No: ${stuone["roll_no"]}, Add: ${stuone["address"]}'),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return EditStudentPage(
                                            rollno: stuone["roll_no"],
                                          );
                                        },
                                      ),
                                    ); //navigate to edit page, pass student roll no to edit
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                onPressed: () async {
                                  await mydb.db.rawDelete(
                                      "DELETE FROM students WHERE roll_no = ?",
                                      [stuone["roll_no"]]);
                                  //delete student data with roll no.
                                  print("Data Deleted");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Student Data Deleted"),
                                    ),
                                  );
                                  getdata();
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
        ),
      ),
    );
  }
}
