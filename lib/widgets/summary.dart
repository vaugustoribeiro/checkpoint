import 'package:checkpoint/models/time_sheet_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timeSheetModel = Provider.of<TimeSheetModel>(context);

    Widget child;

    if (timeSheetModel.isSummaryEmpty) {
      child = ListTile(
        dense: true,
        title: Text(
          'Resumo do dia não encontado!',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      child = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            (timeSheetModel.selectedDayEvents[0]['summary'] as List<dynamic>)
                .map((event) => ListTile(
                      title: Text(
                        '${event['valor']}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        '${event['descricao']}',
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                      dense: true,
                      onTap: () => print('$event tapped!'),
                    ))
                .toList(),
      );
    }

    return Container(
      margin: EdgeInsets.fromLTRB(2, 0, 8, 8),
      child: child,
    );
  }
}
