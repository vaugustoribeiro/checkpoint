import 'dart:core';
import 'package:checkpoint/services/time_sheet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeSheetModel with ChangeNotifier {
  TimeSheetService timeSheetService = TimeSheetService();
  CalendarController calendarController = CalendarController();

  DateTime _validity = DateTime.now();
  Map<String, dynamic> _user = {};
  Map<DateTime, List> _events = {};
  DateTime _selectedDay = DateTime.now();
  List _selectedDayEvents = [];
  String _bank;

  DateTime get validity => _validity;
  Map<DateTime, List> get events => _events;
  Map<String, dynamic> get user => _user;
  DateTime get selectedDay => _selectedDay;
  List get selectedDayEvents => _selectedDayEvents;
  String get bank => _bank;

  bool get isSummaryEmpty =>
      selectedDayEvents.isEmpty || selectedDayEvents[0]['summary'].isEmpty;

  bool get isRecordsEmpty =>
      selectedDayEvents.isEmpty || selectedDayEvents[0]['records'].isEmpty;

  changeValidity(DateTime validity) async {
    _validity = validity;

    var countings = await timeSheetService.get(validity);

    load = countings;
  }

  set bank(String bank) {
    _bank = bank;
    notifyListeners();
  }

  set user(Map<String, dynamic> user) {
    _user = user;
    notifyListeners();
  }

  set events(Map<DateTime, List> events) {
    _events = events;
    notifyListeners();
  }

  set load(Map<String, dynamic> model) {
    var currentDayEventsSetted = false;

    model['days'].forEach((k, v) {
      var date = DateTime.parse(k);

      var dayEvents = [
        {
          'records': v['batidas'],
          'summary': v['totais'],
        },
      ];

      _events[date] = dayEvents;

      if (!currentDayEventsSetted) {
        var formatter = DateFormat('ddMMyyyy');
        if (formatter.format(date) == formatter.format(selectedDay)) {
          _selectedDayEvents = dayEvents;
        }
      }
    });
    _user = model['user'];

    if (_bank == null) {
      _bank = model['bank'];
    }

    notifyListeners();
  }

  selectDay(DateTime day, List events) {
    _selectedDay = day;
    _selectedDayEvents = events;
    notifyListeners();
  }
}
