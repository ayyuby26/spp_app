import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spp_app/bloc/student/student_bloc.dart';
import 'package:spp_app/ui/student_page/student_page_process.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "sK");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Siswa"),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<StudentBloc, StudentState>(builder: (_, state) {
                List<DataRow> _listDataRow = [];
                _listDataRow.clear();

                if (state is StudentLoading)
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "loading...",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                else if (state is StudentLoaded) {
                  _listDataRow = StudentDataRow()
                      .classdataProcess(state.data, _scaffoldKey, _);
                  return StudentDataRow(
                    listDataRow: _listDataRow,
                  );
                }
                return Container();
              })
            ],
          ),
        ),
      ),
    );
  }
}
