import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spp_app/models/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial());

  @override
  Stream<StudentState> mapEventToState(
    StudentEvent event,
  ) async* {
    // SELECT
    if (event is StudentBlocEvent) {
      yield StudentLoading();
      try {
        final List<Student> _list = await Student.getStudent();
        print(_list);
        if (_list != null) yield StudentLoaded(_list);
      } catch (_) {
        yield StudentFailed();
      }
    }

// UPDATE
    if (event is StudentUpdateBlocEvent) {
      yield StudentLoading();
      try {
        final String _message = await Student.updateStudent(
          event.studentId,
          event.classId,
          event.studentName,
          event.sex,
          event.dateOfBirth,
          event.address,
          event.religion,
          event.schoolYear,
        );
        if (_message == "success")
          yield StudentDeleteSuccess(_message);
        else if (_message == "failed")
          yield StudentFailed();
        else
          yield StudentUpdateQueryError();
        print(_message);
      } catch (e) {
        yield StudentUpdateServerError();
      }
    }

    // ADD
    // if (event is StudentBloEvent) {
    //   yield StudentLoading();
    //   try {
    //     List<Student> list = await Student.getStudent();
    //     if (list != null) yield StudentLoaded(list);
    //   } catch (e) {
    //     yield StudentEmpty();
    //   }
    // }
  }
}
