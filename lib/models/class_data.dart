import 'dart:convert';
import 'package:http/http.dart' as http;

class ClassDataList {
  final List<ClassData> classList;

  ClassDataList(this.classList);

  factory ClassDataList.fromJson(List<dynamic> ps) {
    List<ClassData> classData = List<ClassData>();
    classData = ps.map((e) => ClassData.createClassData(e)).toList();
    return ClassDataList(classData);
  }
}

class ClassData {
  final String classId, classLevel, majors, classCode;

  ClassData([this.classId, this.classLevel, this.majors, this.classCode]);

  factory ClassData.createClassData(Map<String, dynamic> obj) {
    return ClassData(
      obj['id_kelas'],
      obj['tingkat_kelas'],
      obj['jurusan'],
      obj['kode_kelas'],
    );
  }

  static Future<List<ClassData>> getClassData() async {
    const String apiURL = 'http://10.0.2.2/spp/class_data/data_kelas.php';
    var apiResult = await http.get(apiURL);
    var jsoN = json.decode(apiResult.body);
    List<ClassData> list1 = [];
    for (int i = 0; i < jsoN.length; i++)
      list1.add(ClassData.createClassData(jsoN[i]));
    return list1;
  }

  static Future<String> classDataDelete(String _id) async {
    final String url = 'http://10.0.2.2/spp/class_data/delete_datakelas.php';
    var result = await http.post(url, body: {'key': _id});

    var jsoN = json.decode(result.body);
    return (jsoN as Map<String, dynamic>)['message'];
  }

  static Future<String> classDataUpdate(
      String _id, String _classLevel, String _majors, String _classCode) async {
    final String url = 'http://10.0.2.2/spp/class_data/classdata_update.php';
    var result = await http.post(url, body: {
      'id': _id,
      'classLevel': _classLevel,
      'majors': _majors,
      'classCode': _classCode,
    });

    var jsoN = json.decode(result.body);
    return (jsoN as Map<String, dynamic>)['message'];
  }

  static Future<String> classDataAdd(
      String _classLevel, String _majors, String _classCode) async {
    final String url = 'http://10.0.2.2/spp/class_data/class_data_add.php';
    var result = await http.post(url, body: {
      'classLevel': _classLevel,
      'majors': _majors,
      'classCode': _classCode,
    });

    var jsoN = json.decode(result.body);
    return (jsoN as Map<String, dynamic>)['message'];
  }
}
