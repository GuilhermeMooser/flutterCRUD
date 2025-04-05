import 'package:flutter/material.dart';
import 'package:flutter_crud/pages/add_student.dart';
import 'package:flutter_crud/service/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getontheload();
    super.initState();
  }

  getontheload() async {
    studentStream = await DatabaseMethods().getStudentsDetails();
    setState(() {});
  }

  Stream? studentStream;

  Widget showStudentsList() {
    return StreamBuilder(
      stream: studentStream,
      builder: (context, AsyncSnapshot snapshots) {
        return snapshots.hasData
            ? ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshots.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot ds = snapshots.data.docs[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Student Name: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ds["name"],
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: ()async{
                                  await DatabaseMethods().deleteStudentData(ds.id);
                                },
                                child: 
                                Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                  size: 25.0,
                                ),
                              ),,
                              )
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Text(
                                "Role No.: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "01",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Text(
                                "Age: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "22",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Text(
                                "Attendance: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              ds["Present"] == false
                                  ? GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods().updateAttendance(
                                        "Present",
                                        ds.id,
                                      );
                                    },
                                    child: Container(
                                      width: 50,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "P",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  : Container(
                                    width: 50,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "P",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              SizedBox(width: 20.0),
                              ds["Absent"] == false
                                  ? GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods().updateAttendance(
                                        "Absent",
                                        ds.id,
                                      );
                                    },
                                    child: Container(
                                      width: 50,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "A",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  : Container(
                                    width: 50,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "A",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
            : Container();
      },
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Attendance",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            showStudentsList(),
            // Material(
            //   elevation: 3.0,
            //   borderRadius: BorderRadius.circular(10),
            //   child: Container(
            //     padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: [
            //             Text(
            //               "Student Name: ",
            //               style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 18.0,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //             Text(
            //               "Guilherme Moser",
            //               style: TextStyle(
            //                 color: Colors.deepPurple,
            //                 fontSize: 20.0,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 5.0),
            //         Row(
            //           children: [
            //             Text(
            //               "Role No.: ",
            //               style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 18.0,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //             Text(
            //               "01",
            //               style: TextStyle(
            //                 color: Colors.deepPurple,
            //                 fontSize: 20.0,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 5.0),
            //         Row(
            //           children: [
            //             Text(
            //               "Age: ",
            //               style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 18.0,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //             Text(
            //               "22",
            //               style: TextStyle(
            //                 color: Colors.deepPurple,
            //                 fontSize: 20.0,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 5.0),
            //         Row(
            //           children: [
            //             Text(
            //               "Attendance: ",
            //               style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 18.0,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             SizedBox(width: 10.0),
            //             Container(
            //               width: 50,
            //               padding: EdgeInsets.all(5),
            //               decoration: BoxDecoration(
            //                 color: Colors.green,
            //                 borderRadius: BorderRadius.circular(5),
            //               ),
            //               child: Center(
            //                 child: Text(
            //                   "P",
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 20.0,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             SizedBox(width: 20.0),
            //             Container(
            //               width: 50,
            //               padding: EdgeInsets.all(5),
            //               decoration: BoxDecoration(
            //                 color: Colors.red,
            //                 borderRadius: BorderRadius.circular(5),
            //               ),
            //               child: Center(
            //                 child: Text(
            //                   "A",
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 20.0,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
