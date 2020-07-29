import 'package:checkpoint/models/time_sheet_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timeSheetModel = Provider.of<TimeSheetModel>(context);
    return BottomAppBar(
      color: Colors.blue,
      elevation: 4,
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: Container(
        color: Colors.transparent,
        height: 40,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: Colors.white,
            ),
            Container(
              width: 4,
            ),
            Text(
              timeSheetModel.bank,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
