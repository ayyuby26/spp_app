part of 'classdata_bloc.dart';

abstract class ClassdataState extends Equatable {
  @override
  List<Object> get props => [];
}

class ClassdataInitial extends ClassdataState {}

class ClassdataLoading extends ClassdataState {}

class ClassdataLoaded extends ClassdataState {
  final _result;

  ClassdataLoaded(this._result);

  List<ClassData> get data => _result;
}

class ClassdataFailed extends ClassdataState {}

class ClassdataEmpty extends ClassdataState {}

/*












 */

abstract class ClassdataDeleteState extends ClassdataState {
  @override
  List<Object> get props => [];
}

class ClassdatadeleteInitial extends ClassdataState {}

class ClassdatadeleteSuccess extends ClassdataState {
  final String _result;

  ClassdatadeleteSuccess(this._result);

  String get message => _result;

  @override
  List<Object> get resultDelete => [_result];
}

class ClassdataDeleteLoading extends ClassdataState {}

class ClassdataDeleteFailed extends ClassdataState {}

/*












 */
class ClassdataUpdateSuccess extends ClassdataState {
  // final String _result;

  // ClassdataUpdateSuccess(this._result);

  // String get message => _result;

  // @override
  // List<Object> get resultUpdate => [_result];
}

class ClassdataUpdateLoading extends ClassdataState {}

class ClassdataUpdateFailed extends ClassdataState {}

class ClassdataUpdateQueryError extends ClassdataState {}

class ClassdataUpdateServerError extends ClassdataState {}



/// Class Data Fetch Success
class ClassdataAddSucces extends ClassdataState {
  final String _message;

  ClassdataAddSucces(this._message);

  String get _result => _message; 

  @override
  List<Object> get result => [_message];
}

class ClassdataAddFailed extends ClassdataState {}
class ClassdataAddLoading extends ClassdataState {}
class ClassdataAddServerError extends ClassdataState {}