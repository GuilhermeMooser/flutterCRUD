// local_database.dart - simula um banco de dados usando memória local
import 'dart:async';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();

  final List<Map<String, dynamic>> _students = [];
  final StreamController<List<Map<String, dynamic>>> _controller =
      StreamController.broadcast();

  Stream<List<Map<String, dynamic>>> getStudentsStream() {
    _controller.add(_students);
    return _controller.stream;
  }

  void addStudent(Map<String, dynamic> studentData) {
    _students.add(studentData);
    _controller.add(_students);
  }

  void deleteStudent(String id) {
    _students.removeWhere((student) => student['id'] == id);
    _controller.add(_students);
  }

  void updateAttendance(String id, String status) {
    for (var student in _students) {
      if (student['id'] == id) {
        student['Present'] = status == 'Present';
        student['Absent'] = status == 'Absent';
      }
    }
    _controller.add(_students);
  }
}
