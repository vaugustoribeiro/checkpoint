import 'package:checkpoint/models/auth_model.dart';
import 'package:checkpoint/screens/loading_screen.dart';
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
      home: ChangeNotifierProvider(
        create: (_) => AuthModel(),
        child: Scaffold(
          body: LoadingScreen(),
        ),
      ),
    );
  }
}
