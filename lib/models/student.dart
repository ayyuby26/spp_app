import 'dart:convert';
import 'package:http/http.dart' as http;

class Student {
  final String studentId,
      classId,
      studentName,
      sex,
      dateOfBirth,
      address,
      religion,
      schoolYear;

  Student(
    this.studentId,
    this.classId,
    this.studentName,
    this.sex,
    this.dateOfBirth,
    this.address,
    this.religion,
    this.schoolYear,
  );

  factory Student.fromJson(Map<String, dynamic> k) => Student(
        k['id_siswa'],
        k['id_kelas'],
        k['nama_siswa'],
        k['jenis_kelamin'],
        k['tanggal_lahir'],
        k['alamat'],
        k['agama'],
        k['tahun_ajaran'],
      );

  static Future<List<Student>> getStudent() async {
    const String apiURL = 'http://10.0.2.2/spp/student_data/student_data.php';
    var apiResult = await http.get(apiURL);
    List jsoN = json.decode(apiResult.body) as List;
    List<Student> list1 = [];
    for (int i = 0; i < jsoN.length; i++) list1.add(Student.fromJson(jsoN[i]));
    return list1;
  }

  static Future<String> deleteStudent(String _studentId) async {
    final String url = 'http://10.0.2.2/spp/class_data/student_delete.php';
    var result = await http.post(url, body: {'id_siswa': _studentId});

    var jsoN = json.decode(result.body);
    return (jsoN as Map<String, dynamic>)['message'];
  }

  static Future<String> updateStudent(
    String _studentId,
    String _classId,
    String _studentName,
    String _sex,
    String _dateOfBirth,
    String _address,
    String _religion,
    String _schoolYear,
  ) async {
    const String url = 'http://10.0.2.2/spp/class_data/student_update.php';
    var result = await http.post(url, body: {
      'studentId': _studentId,
      'classId': _classId,
      'studentName': _studentName,
      'sex': _sex,
      'dateOfBirth': _dateOfBirth,
      'address': _address,
      'religion': _religion,
      'schoolYear': _schoolYear,
    });

    var jsoN = json.decode(result.body);
    return (jsoN as Map<String, dynamic>)['message'];
  }

  static Future<String> addStudent(
    String _studentId,
    String _classId,
    String _studentName,
    String _sex,
    String _dateOfBirth,
    String _address,
    String _religion,
    String _schoolYear,
  ) async {
    const String url = 'http://10.0.2.2/spp/class_data/student_add.php';
    var result = await http.post(url, body: {
      'studentId': _studentId,
      'classId': _classId,
      'studentName': _studentName,
      'sex': _sex,
      'dateOfBirth': _dateOfBirth,
      'address': _address,
      'religion': _religion,
      'schoolYear': _schoolYear,
    });
    var jsoN = json.decode(result.body);
    return (jsoN as Map<String, dynamic>)['message'];
  }
}
