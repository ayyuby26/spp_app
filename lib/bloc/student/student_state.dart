part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState {
  final _result;

  StudentLoaded(this._result);

  get data => _result;
}

class StudentFailed extends StudentState {}


/*












 */

class StudentDeleteState extends StudentState {}

class StudentDeleteInitial extends StudentState {}

class StudentDeleteSuccess extends StudentState {
  final String _result;

  StudentDeleteSuccess(this._result);

  String get message => _result;
}

class StudentDeleteLoading extends StudentState {}

class StudentDeleteFailed extends StudentState {}

/*












 */

class StudentUpdateSuccess extends StudentState {}

class StudentUpdateFailed extends StudentState {}

class StudentUpdateQueryError extends StudentState {}

class StudentAddLoading extends StudentState {}

class StudentAddServerError extends StudentState {}
