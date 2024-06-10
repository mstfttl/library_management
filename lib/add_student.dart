import 'package:flutter/material.dart';
import 'package:library_management/student_repository.dart';
import 'package:library_management/students.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();
    TextEditingController departmentController = TextEditingController();
    TextEditingController studentNumberController = TextEditingController();
    final studentRepository = StudentRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenci Ekleme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Öğrenci Bilgileri',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Ad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: surnameController,
                decoration: InputDecoration(
                  labelText: 'Soyad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: departmentController,
                decoration: InputDecoration(
                  labelText: 'Bölüm',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: studentNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Öğrenci Numarası',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  Student student = Student(
                    name: nameController.text,
                    surname: surnameController.text,
                    department: departmentController.text,
                    studentNumber: studentNumberController.text,
                  );
                  await studentRepository.saveStudent(student);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Ekle',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}