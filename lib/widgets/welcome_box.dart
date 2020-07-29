import 'package:checkpoint/models/time_sheet_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WelcomeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timeSheetModel = Provider.of<TimeSheetModel>(context);
    return Text(
      'Olá, ${toBeginningOfSentenceCase(timeSheetModel.user['nome'].split(' ')[0].toLowerCase())}',
    );
  }
}
