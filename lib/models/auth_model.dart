import 'package:flutter/material.dart';

class AuthModel with ChangeNotifier {
  bool _success = false;

  bool get success => _success;

  set success(bool success) {
    print('set success(bool $success)');
    _success = success;
    notifyListeners();
  }
}
