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
  final String _studentId;

  StudentDeleteBlocEvent(this._studentId);

  @override
  List<Object> get props => [_studentId];
}

/// STUDENT UPDATE
class StudentUpdateBlocEvent extends StudentEvent {
  final String _studentId,
      _classId,
      _studentName,
      _sex,
      _dateOfBirth,
      _address,
      _schoolYear;

  StudentUpdateBlocEvent(
    this._studentId,
    this._classId,
    this._studentName,
    this._sex,
    this._dateOfBirth,
    this._address,
    this._schoolYear,
  );

  @override
  List<Object> get props => [
        _studentId,
        _classId,
        _studentName,
        _sex,
        _dateOfBirth,
        _address,
        _schoolYear
      ];
}

// STUDENT ADD
class StudentAddBlocEvent extends StudentEvent {
  final String _studentId,
      _classId,
      _studentName,
      _sex,
      _dateOfBirth,
      _address,
      _schoolYear;

  StudentAddBlocEvent(this._studentId, this._classId, this._studentName, this._sex, this._dateOfBirth, this._address, this._schoolYear);


}