import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spp_app/bloc/student/student_bloc.dart';
import 'package:intl/intl.dart';

enum StudentDialogType { edit, add }

class StudentPageDialog {
  static addEditDialog(
    final BuildContext _,
    final StudentDialogType type, {
    @required final String studentId,
    @required final String classId,
    @required final String studentName,
    @required final String sex,
    @required final String dateOfBirth,
    @required final String address,
    @required final String religion,
    @required final String schoolYear,
  }) {
    final _studentIdCtrl = TextEditingController(
      text: studentId.isEmpty ? null : studentId,
    );
    final _classIdCtrl = TextEditingController(
      text: studentId.isEmpty ? null : classId,
    );
    final _studentNameCtrl = TextEditingController(
      text: studentId.isEmpty ? null : studentName,
    );
    final _sexCtrl = TextEditingController(
      text: studentId.isEmpty ? null : sex,
    );
    final _dateOfBirthCtrl = TextEditingController(
      text: studentId.isEmpty ? null : dateOfBirth,
    ).obs;
    final _addressCtrl = TextEditingController(
      text: studentId.isEmpty ? null : address,
    );
    final _religionCtrl = TextEditingController(
      text: studentId.isEmpty ? null : religion,
    ).obs;
    final _schoolYearCtrl = TextEditingController(
      text: studentId.isEmpty ? null : schoolYear,
    );

    // ignore: close_sinks
    final bloc = BlocProvider.of<StudentBloc>(_);

    final _typeDialog = StudentDialogType.add == type;
    void onClick(RxString _date) {
      Get.back();
      if (_typeDialog)
        bloc.add(
          StudentAddBlocEvent(
            studentId: studentId,
            classId: classId,
            studentName: studentName,
            sex: sex,
            dateOfBirth: dateOfBirth,
            address: address,
            religion: religion,
            schoolYear: schoolYear,
          ),
        );
      else {
        bloc.add(
          StudentUpdateBlocEvent(
            studentId: _studentIdCtrl.text,
            classId: _classIdCtrl.text,
            studentName: _studentNameCtrl.text,
            sex: _sexCtrl.text,
            dateOfBirth: _dateOfBirthCtrl.value.text + ", " + _date.value,
            address: _addressCtrl.text,
            religion: _religionCtrl.value.text,
            schoolYear: _schoolYearCtrl.text,
          ),
        );
      }
    }

    showDialog(
        context: _,
        builder: (_) {
          var _genderType = ''.obs;
          var _date = "".obs;
          List<String> _religionsList = [
            'Islam',
            'Kristen',
            'Hindu',
            'Budha',
            'Khatolik',
          ];
          var _religionSelected = _religionCheck(_religionCtrl.value).obs;

          _sexcw(_sexCtrl, _genderType);
          _inputCity(_dateOfBirthCtrl.value, _date);

          return CupertinoAlertDialog(
            title: Text(
              _typeDialog ? "Tambah" : "Ubah" + " Data",
            ),
            content: Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("ID Siswa"),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      _studentIdCtrl.text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // CupertinoTextField(
                  //   enabled: false,
                  //   controller: _studentIdCtrl,
                  //   placeholder: "ID Siswa",
                  //   keyboardType: TextInputType.number,
                  // ),
                  const SizedBox(height: 15),
                  // +++++++++++++++++++++++++
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("ID Kelas"),
                  ),
                  const SizedBox(height: 5),
                  CupertinoTextField(
                    controller: _classIdCtrl,
                    placeholder: "ID Kelas",
                  ),
                  const SizedBox(height: 15),
                  // +++++++++++++++++++++++++
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("Nama Siswa"),
                  ),
                  const SizedBox(height: 5),
                  CupertinoTextField(
                    controller: _studentNameCtrl,
                    placeholder: "Nama Siswa",
                  ),
                  const SizedBox(height: 15),
                  // +++++++++++++++++++++++++
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("Jenis Kelamin"),
                  ),
                  const SizedBox(height: 0),
                  // CupertinoTextField(
                  //   controller: _sexCtrl,
                  //   placeholder: "Jenis Kelamin",
                  // ),

                  Obx(
                    () => Material(
                      color: Colors.transparent,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                              title: const Text('Laki-laki'),
                              value: 'Laki-laki',
                              groupValue: _genderType.value,
                              onChanged: (v) => _genderType.value = v),
                          RadioListTile(
                              title: const Text('Perempuan'),
                              value: 'Perempuan',
                              groupValue: _genderType.value,
                              onChanged: (v) => _genderType.value = v),
                        ],
                      ),
                    ),
                  ),

                  // Radio(value: "Laki-laki", groupValue: null, onChanged: null),
                  const SizedBox(height: 15),
                  // +++++++++++++++++++++++++
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("Tempat, Tanggal Lahir"),
                  ),
                  // const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        child: CupertinoTextField(
                          controller: _dateOfBirthCtrl.value,
                          placeholder: "Bekasi, 01-01-2001",
                        ),
                      ),
                      SizedBox(width: 10),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.blueGrey[50],
                        onPressed: () {
                          so(_, _date);
                        },
                        child: Obx(
                          () => Text(
                            _date.value.isEmpty ? "Tanggal lahir" : _date.value,
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  // +++++++++++++++++++++++++
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("Alamat"),
                  ),
                  const SizedBox(height: 5),
                  CupertinoTextField(
                    controller: _addressCtrl,
                    placeholder: "Alamat",
                    minLines: 2,
                    maxLines: null,
                  ),
                  const SizedBox(height: 15),
                  // +++++++++++++++++++++++++
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("Agama"),
                  ),
                  const SizedBox(height: 5),
                  // CupertinoTextField(
                  //   controller: _religionCtrl,
                  //   placeholder: "Agama",
                  // ),
                  Obx(
                    () => Material(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: const OutlineInputBorder(),
                              ),
                              hint: Text("Pilih agama"),
                              value: _religionSelected.value,
                              items: _religionsList
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String v) {
                                _religionSelected.value = v;
                                _religionCtrl.value.text = v;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // +++++++++++++++++++++++++
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("Tahun Ajaran"),
                  ),
                  const SizedBox(height: 5),
                  CupertinoTextField(
                    controller: _schoolYearCtrl,
                    placeholder: "Tahun Ajaran",
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Batal"),
                onPressed: Get.back,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(
                  _typeDialog ? "Tambah" : "Simpan",
                ),
                onPressed: () => onClick(_date),
              )
            ],
          );
        });
  }

  static String _religionCheck(TextEditingController _religionCtrl) {
    switch (_religionCtrl.text) {
      case "Islam":
        return 'Islam';
        break;
      case "Kristen":
        return 'Kristen';
        break;
      case "Hindu":
        return 'Hindu';
        break;
      case "Budha":
        return 'Budha';
        break;
      case "Khatolik":
        return 'Khatolik';
        break;
      default:
        return null;
        break;
    }
  }

  static _sexcw(
    TextEditingController _sexCtrl,
    RxString _genderType,
  ) {
    _sexCtrl.text == "Laki-laki"
        ? _genderType.value = "Laki-laki"
        : _genderType.value = "Perempuan";
  }

  static void _inputCity(
    TextEditingController _dateOfBirthCtrl,
    RxString _date,
  ) {
    final List<String> t = _dateOfBirthCtrl.text.split(", ");
    _inputDateBirth(_dateOfBirthCtrl, _date);
    _dateOfBirthCtrl.text = t[0];
  }

  static void _inputDateBirth(
    TextEditingController _dateOfBirthCtrl,
    RxString _date,
  ) {
    final List<String> t = _dateOfBirthCtrl.text.split(", ");
    final _dateBirth = t[1];
    _date.value = _dateBirth;
  }

  static Future<void> so(
    BuildContext context,
    RxString _date,
  ) async {
    final DateTime _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (_picked != null) _date.value = DateFormat("d-M-y").format(_picked);
  }
}
