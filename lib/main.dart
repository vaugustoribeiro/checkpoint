import 'package:checkpoint/models/auth_model.dart';
import 'package:checkpoint/models/time_sheet_model.dart';
import 'package:checkpoint/screens/loading_screen.dart';
import 'package:checkpoint/screens/login_screen.dart';
import 'package:checkpoint/screens/time_sheet_screen.dart';
import 'package:checkpoint/screens/checkpoint_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() => initializeDateFormatting().then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkpoint',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        LoadingScreen.route: (_) => LoadingScreen(),
        LoginScreen.route: (_) => LoginScreen(),
        TimeSheetScreen.route: (_) => TimeSheetScreen(),
        CheckpointScreen.route: (_) => CheckpointScreen(),
      },
      initialRoute: LoadingScreen.route,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => TimeSheetModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => AuthModel(),
            ),
          ],
          child: Scaffold(
            body: child,
          ),
        );
      },
    );
  }
}
