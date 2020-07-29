import 'package:checkpoint/models/time_sheet_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timeSheetModel = Provider.of<TimeSheetModel>(context);

    // if (timeSheetModel.isRecordsEmpty && timeSheetModel.isSummaryEmpty) {
    //   return Container();
    // }

    var formatter = DateFormat('dd/MM/yyyy');
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(8),
        //   topRight: Radius.circular(8),
        // ),
      ),
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Center(
        child: Text(
          formatter.format(timeSheetModel.selectedDay),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
