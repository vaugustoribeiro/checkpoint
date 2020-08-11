import 'package:checkpoint/models/time_sheet_model.dart';
import 'package:checkpoint/services/simple_snack_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timeSheetModel = Provider.of<TimeSheetModel>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32)),
      ),
      margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: TableCalendar(
        calendarController: timeSheetModel.calendarController,
        locale: "pt_BR",
        onDaySelected: timeSheetModel.selectDay,
        events: timeSheetModel.events,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.horizontalSwipe,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Mês',
        },
        // endDay: DateTime.now(),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.white70),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
        ),
        headerStyle: HeaderStyle(
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        onVisibleDaysChanged: (dt1, _, __) async {
          SimpleSnackService.busy(context, 'Carregando registros...');
          await timeSheetModel.changeValidity(dt1);
          SimpleSnackService.clear(context);
        },
        builders: CalendarBuilders(
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];
            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  right: 0,
                  child: _buildEventsMarker(context, date, events),
                ),
              );
            }
            return children;
          },
          weekendDayBuilder: (context, date, events) {
            return Container(
              decoration: BoxDecoration(
                color: timeSheetModel.calendarController.isSelected(date)
                    ? Colors.blue
                    : Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
              ),
              margin: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: timeSheetModel.calendarController.isSelected(date)
                        ? Colors.white
                        : Colors.deepOrange,
                  ),
                ),
              ),
            );
          },
          dayBuilder: (context, date, events) {
            return Container(
              decoration: BoxDecoration(
                color: timeSheetModel.calendarController.isSelected(date)
                    ? Colors.blue
                    : Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
              ),
              margin: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: timeSheetModel.calendarController.isSelected(date)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEventsMarker(BuildContext context, DateTime date, List events) {
    var timeSheetModel = Provider.of<TimeSheetModel>(context);

    var recordsCount = events[0]['records'].length;

    if (recordsCount == 0) {
      return Container();
    }

    var isDayValid = recordsCount % 2 == 0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: timeSheetModel.calendarController.isSelected(date)
              ? Colors.blue
              : isDayValid ? Colors.green[600] : Colors.red[600],
          borderRadius: BorderRadius.circular(8)),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          recordsCount.toString(),
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
