// home.dart adaptado para usar LocalDatabase
import 'package:flutter/material.dart';
import 'package:flutter_crud/pages/add_student.dart';
import 'package:flutter_crud/service/local_database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<List<Map<String, dynamic>>> studentStream;

  @override
  void initState() {
    super.initState();
    studentStream = LocalDatabase().getStudentsStream();
  }

  Widget showStudentsList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: studentStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final students = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Name: ${student['name']}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            LocalDatabase().deleteStudent(student['id']);
                          },
                        ),
                      ],
                    ),
                    Text("Roll No.: ${student['rollNumber']}"),
                    Text("Age: ${student['age']}"),
                    Row(
                      children: [
                        Text("Attendance: "),
                        attendanceButton(student, 'Present', Colors.green),
                        SizedBox(width: 10),
                        attendanceButton(student, 'Absent', Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget attendanceButton(
    Map<String, dynamic> student,
    String type,
    Color color,
  ) {
    bool isMarked = student[type] == true;
    return GestureDetector(
      onTap: () {
        LocalDatabase().updateAttendance(student['id'], type);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isMarked ? color : Colors.transparent,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            type[0],
            style: TextStyle(
              color: isMarked ? Colors.white : color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudent()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Student ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Attendance",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(child: showStudentsList()),
          ],
        ),
      ),
    );
  }
}
