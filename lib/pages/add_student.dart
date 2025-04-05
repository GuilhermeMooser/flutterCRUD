// add_student.dart adaptado para usar armazenamento local
import 'package:flutter/material.dart';
import 'package:flutter_crud/service/local_database.dart';
import 'package:random_string/random_string.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined),
                ),
                SizedBox(width: 80.0),
                Text(
                  "Add ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Student",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Text("Student Name:"),
            TextField(controller: nameController),
            SizedBox(height: 20.0),
            Text("Student Age:"),
            TextField(controller: ageController),
            SizedBox(height: 20.0),
            Text("Student Roll No.:"),
            TextField(controller: rollNumberController),
            SizedBox(height: 40.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      ageController.text.isNotEmpty &&
                      rollNumberController.text.isNotEmpty) {
                    String id = randomAlphaNumeric(10);
                    LocalDatabase().addStudent({
                      'id': id,
                      'name': nameController.text,
                      'age': ageController.text,
                      'rollNumber': rollNumberController.text,
                      'Present': false,
                      'Absent': false,
                    });
                    nameController.clear();
                    ageController.clear();
                    rollNumberController.clear();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Student Added!')));
                  }
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
