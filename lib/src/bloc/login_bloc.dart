import 'dart:async';

import 'package:flutterforms/src/bloc/Validator.dart';
import 'package:rxdart/rxdart.dart';
export 'package:flutterforms/src/bloc/login_bloc.dart';

class LoginBloc with Validator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(isValidEmail);

  Stream<String> get passwordStrem =>
      _passwordController.stream.transform(isValidPassword);

  Function(String) get updateEmail => _emailController.sink.add;

  Function(String) get updatePassword => _passwordController.sink.add;

  Stream<bool> get isValidFormStream =>
      CombineLatestStream.combine2(emailStream, passwordStrem, (e, p) => true);

  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
