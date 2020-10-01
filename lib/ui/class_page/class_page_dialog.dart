import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spp_app/bloc/class_data/classdata_bloc.dart';

class ClassPageDialog {
  static addEditDialog(
    final BuildContext _, [
    final String id = "",
    final String classLevel,
    final String majors,
    final String classCode,
  ]) {
    final classLevelController = TextEditingController(
      text: id.isEmpty ? null : classLevel,
    );
    final majorsController = TextEditingController(
      text: id.isEmpty ? null : majors,
    );
    final classCodeController = TextEditingController(
      text: id.isEmpty ? null : classCode,
    );
    // ignore: close_sinks
    final bloc = BlocProvider.of<ClassdataBloc>(_);

    void onClick() {
      Get.back();
      if (id.isEmpty)
        bloc.add(
          ClassdataAddBlocEvent(
            classLevelController.text,
            majorsController.text,
            classCodeController.text,
          ),
        );
      else
        bloc.add(
          ClassdataUpdateBlocEvent(
            id,
            classLevelController.text,
            majorsController.text,
            classCodeController.text,
          ),
        );
    }

    showDialog(
      context: _,
      builder: (_) => CupertinoAlertDialog(
        title: Text(id.isEmpty ? "Tambah" : "Ubah" + " Data"),
        content: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              CupertinoTextField(
                controller: classLevelController,
                placeholder: "Kelas",
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: majorsController,
                placeholder: "Jurusan",
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                onChanged: (e) => classCodeController.text = e.toUpperCase(),
                textCapitalization: TextCapitalization.characters,
                maxLength: 1,
                controller: classCodeController,
                placeholder: "Kode Kelas",
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
            child: Text(id.isEmpty ? "Tambah" : "Simpan"),
            onPressed: onClick,
          )
        ],
      ),
    );
  }
}
