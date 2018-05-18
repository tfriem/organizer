import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../app/model.dart';
import '../core/date.dart';
import 'actions.dart';

class HorizontalCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      reverse: true,
      itemExtent: 72.0,
      itemBuilder: (BuildContext context, int index) {
        Date day = Date
            .fromDateTime(DateTime.now().subtract(Duration(days: index - 2)));
        return _buildDayItem(day);
      },
    );
  }

  Widget _buildDayItem(Date day) {
    return StoreConnector<AppState, DayViewModel>(
      converter: (Store<AppState> store) => DayViewModel(
          store.state.workTimeTracker.selectedDate == day,
          store.state.workTimeTracker.bookings[day]?.start != null &&
              store.state.workTimeTracker.bookings[day]?.end != null,
          () => store.dispatch(WorkTimeSelectDay(day))),
      builder: (BuildContext context, DayViewModel vm) {
        final dateTime = day.toDateTime();
        final backgroundColor = vm.selected
            ? Theme.of(context).accentColor
            : Theme.of(context).cardColor;
        final textColor = vm.selected
            ? Theme.of(context).accentTextTheme.button.color
            : vm.fullyBooked
                ? Colors.green
                : Theme.of(context).textTheme.button.color;
        return FlatButton(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(DateFormat("d").format(dateTime),
                  style: TextStyle(
                      color: textColor,
                      decorationColor: textColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400)),
              Text(
                DateFormat("E").format(dateTime),
                style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
              Text(DateFormat("MMM").format(dateTime),
                  style: TextStyle(color: textColor, fontSize: 10.0)),
            ],
          ),
          onPressed: vm.onClick,
        );
      },
    );
  }
}

@immutable
class DayViewModel {
  final bool selected;
  final bool fullyBooked;
  final VoidCallback onClick;

  DayViewModel(this.selected, this.fullyBooked, this.onClick);
}
