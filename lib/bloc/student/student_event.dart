part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class StudentBlocEvent extends StudentEvent {}

class StudentReset extends StudentEvent {}

/// STUDENT DELETE
class StudentDeleteBlocEvent extends StudentEvent {
  final String studentId;

  StudentDeleteBlocEvent(this.studentId);

  @override
  List<Object> get props => [studentId];
}

/// STUDENT UPDATE
class StudentUpdateBlocEvent extends StudentEvent {
  final String studentId;
  final String classId;
  final String studentName;
  final String sex;
  final String dateOfBirth;
  final String address;
  final String religion;
  final String schoolYear;

  StudentUpdateBlocEvent({
    this.studentId,
    this.classId,
    this.studentName,
    this.sex,
    this.dateOfBirth,
    this.address,
    this.religion,
    this.schoolYear,
  });

  @override
  List<Object> get props => [
        studentId,
        classId,
        studentName,
        sex,
        dateOfBirth,
        address,
        religion,
        schoolYear,
      ];
}

// STUDENT ADD
class StudentAddBlocEvent extends StudentEvent {
  final String studentId,
      classId,
      studentName,
      sex,
      dateOfBirth,
      address,
      religion,
      schoolYear;

  StudentAddBlocEvent({
    this.studentId,
    this.classId,
    this.studentName,
    this.sex,
    this.dateOfBirth,
    this.address,
    this.religion,
    this.schoolYear,
  });
}
