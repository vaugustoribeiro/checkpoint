import 'package:checkpoint/models/auth_model.dart';
import 'package:checkpoint/models/time_sheet_model.dart';
import 'package:checkpoint/screens/login_screen.dart';
import 'package:checkpoint/screens/time_sheet_screen.dart';
import 'package:checkpoint/services/time_sheet_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TimeSheetService().get(DateTime.now()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return ChangeNotifierProvider(
              create: (_) {
                TimeSheetModel model = TimeSheetModel();
                model.load = snapshot.data;
                return model;
              },
              child: TimeSheetScreen(),
            );
          }
        } else {
          return Center(
            child: Text('Loading...'),
          );
        }
      },
    );
  }
}
