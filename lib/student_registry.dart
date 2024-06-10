import 'package:flutter/material.dart';
import 'package:library_management/student_repository.dart';
import 'package:library_management/students.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    final studentRepository = StudentRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenci Listesi'),
      ),
      body: StreamBuilder<List<Student>>(
        stream: studentRepository.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text('${student.surname} - ${student.department}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}