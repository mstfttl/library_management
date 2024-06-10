class Student {
  String? id;
  String name;
  String surname;
  String department;
  String studentNumber;

  Student({
    this.id,
    required this.name,
    required this.surname,
    required this.department,
    required this.studentNumber,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String?,
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      department: json['department'] as String? ?? '',
      studentNumber: json['studentNumber'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'department': department,
      'studentNumber': studentNumber,
    };
  }

  String getFullName() {
    return '$name $surname';
  }
}