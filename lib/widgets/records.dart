import 'package:checkpoint/models/time_sheet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Records extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timeSheetModel = Provider.of<TimeSheetModel>(context);

    Widget child;

    if (timeSheetModel.isRecordsEmpty) {
      child = ListTile(
        dense: true,
        title: Text(
          'Nenhum registro encontrado!',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      child = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            (timeSheetModel.selectedDayEvents[0]['records'] as List<dynamic>)
                .map((event) => ListTile(
                      title: Text(
                        '${event['hora']}',
                        style: TextStyle(
                          color: event['pending'] != null
                              ? Colors.deepOrange
                              : Colors.green,
                        ),
                      ),
                      subtitle: Text(
                        '${event['motivo'] ?? 'Registro automágico'}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      dense: true,
                      onTap: () => print('$event tapped!'),
                    ))
                .toList(),
      );
    }

    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 2, 8),
      child: child,
    );
  }
}
