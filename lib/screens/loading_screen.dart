import 'package:checkpoint/models/auth_model.dart';
import 'package:checkpoint/models/time_sheet_model.dart';
import 'package:checkpoint/screens/login_screen.dart';
import 'package:checkpoint/screens/time_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  static const String route = '/loading';

  @override
  Widget build(BuildContext context) {
    AuthModel authModel = Provider.of<AuthModel>(context);
    if (authModel.success) {
      return Teste();
    }
    return LoginScreen();
  }
}

class Teste extends StatelessWidget {
  static const String route = '/loading';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TimeSheetModel>(context);

    if (provider.ready) {
      return TimeSheetScreen();
    }

    return Center(
      child: Text('Loading...'),
    );
  }
}
