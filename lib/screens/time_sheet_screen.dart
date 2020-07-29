import 'package:checkpoint/screens/checkpoint_screen.dart';
import 'package:checkpoint/widgets/bank.dart';
import 'package:checkpoint/widgets/calendar.dart';
import 'package:checkpoint/widgets/details.dart';
import 'package:checkpoint/widgets/welcome_box.dart';
import 'package:flutter/material.dart';

class TimeSheetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: WelcomeBox(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CheckpointScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Bank(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Calendar(),
            Details(),
            Container(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
