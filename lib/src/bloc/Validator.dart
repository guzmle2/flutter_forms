import 'dart:async';

class Validator {
  final isValidPassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    value.length >= 6 ? sink.add(value) : sink.addError('min 6 characters');
  });

  final isValidEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(pattern);
    regExp.hasMatch(value) ? sink.add(value) : sink.addError('Email Invalid');
  });
}
