class DatabaseMethods {
  Future addStudent(Map<String, dynamic> studentInfoMap, String id) async {
    // return await FirebaseFirestore.instance.collection("Students").doc(id).set(studentInfoMap);
  }

  Future<Stream<QuerySnapshot>> getStudentsDetails() async {
    // return await FirebaseFirestore.instance.collection("Students").snapshots();
  }

  updateAttendance(String attendancecase, String id) async {
    // return await firebasefriestore.instance.collection("sTUDANTES").doc(id).update({})
  }

  deleteStudentData(String id) async {
    // return await firebasefriestore.instance.collection("sTUDANTES").doc(id).update({})
  }
}
