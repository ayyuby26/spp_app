import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spp_app/bloc/student/student_bloc.dart';

enum StudentDialogType { edit, add }
enum SingingCharacter { lafayette, jefferson }
class StudentPageDialog {
  
    var  _sexType = 1;

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
    );
    final _addressCtrl = TextEditingController(
      text: studentId.isEmpty ? null : address,
    );
    final _religionCtrl = TextEditingController(
      text: studentId.isEmpty ? null : religion,
    );
    final _schoolYearCtrl = TextEditingController(
      text: studentId.isEmpty ? null : schoolYear,
    );

    // ignore: close_sinks
    final bloc = BlocProvider.of<StudentBloc>(_);

    final _typeDialog = StudentDialogType.add == type;
    void onClick() {
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
            dateOfBirth: _dateOfBirthCtrl.text,
            address: _addressCtrl.text,
            religion: _religionCtrl.text,
            schoolYear: _schoolYearCtrl.text,
          ),
        );
        print("object");
      }
    }

    showDialog(
      context: _,
      builder: (_) => CupertinoAlertDialog(
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
              const SizedBox(height: 5),
              // CupertinoTextField(
              //   controller: _sexCtrl,
              //   placeholder: "Jenis Kelamin",
              // ),
        //               RadioListTile(
        //   title: const Text('Laki-laki'),
        //   value: 1,
        //   groupValue: _sexType,
        //   onChanged: ( value) {
        //     setState(() {
        //       _character = value;
        //     });
        //   },
        // ),
        // RadioListTile(
        //   title: const Text('perempuan'),
        //   value: 0,
        //   groupValue: _sexType,
        //   onChanged: ( value) {
        //     setState(() {
        //       _character = value;
        //     });
        //   },
        // ),
              Radio(value: "Laki-laki", groupValue: null, onChanged: null),
              const SizedBox(height: 15),
              // +++++++++++++++++++++++++
              Container(
                alignment: Alignment.bottomLeft,
                child: Text("Tempat, Tanggal Lahir"),
              ),
              const SizedBox(height: 5),
              CupertinoTextField(
                controller: _dateOfBirthCtrl,
                placeholder: "Bekasi, 01-01-2001",
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
              CupertinoTextField(
                controller: _religionCtrl,
                placeholder: "Agama",
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
            onPressed: onClick,
          )
        ],
      ),
    );
  }
}
