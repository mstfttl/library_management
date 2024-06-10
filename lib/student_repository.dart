import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_management/students.dart';

class StudentRepository {
  final CollectionReference _studentsCollection =
  FirebaseFirestore.instance.collection('students');

  Future<void> saveStudent(Student student) async {
    await _studentsCollection.add(student.toJson());
  }

  Stream<List<Student>> getStudents() {
    return _studentsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Student.fromJson(doc.data() as Map<String, dynamic>)..id = doc.id;
      }).toList();
    });
  }
}
