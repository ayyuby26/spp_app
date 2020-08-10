part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountIsWrong extends AccountState {}

class AccountIsLoading extends AccountState {}

class AccountIsValid extends AccountState {
  final _login;

  AccountIsValid(this._login);

  Account get login => _login;
}

class AccountNotLogin extends AccountState {}
