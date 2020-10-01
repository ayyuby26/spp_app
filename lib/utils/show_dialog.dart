import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

loadingDialog(
  final BuildContext _,
  final GlobalKey<FormState> _alert,
) =>
    showDialog(
      context: _,
      builder: (_) => CupertinoAlertDialog(
        key: _alert,
        content: Center(
          child: Column(
            children: [
              Container(
                child: const FlareActor(
                  "assets/Loader.flr",
                  fit: BoxFit.contain,
                  animation: "Loading",
                ),
                height: 150,
                width: 150,
              ),
            ],
          ),
        ),
      ),
    );
Future<bool> deleteDialog(
  final BuildContext context,
  final String content,
) async =>
    await showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Konfirmasi hapus"),
        content: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Text(content),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => Get.back(result: false),
            isDefaultAction: false,
            child: const Text("Batal"),
          ),
          CupertinoDialogAction(
            onPressed: () => Get.back(result: true),
            textStyle: const TextStyle(color: Colors.red),
            isDefaultAction: true,
            child: const Text("Hapus"),
          ),
        ],
      ),
    );

errorDialog(final BuildContext _) => showDialog(
      context: _,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Kesalahan ditemukan"),
        content: Container(
          padding: EdgeInsets.only(top: 15),
          child: const Text("Tidak dapat terhubung ke server"),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: Get.back,
            isDefaultAction: true,
            child: Text("Tutup"),
          ),
        ],
      ),
    );
