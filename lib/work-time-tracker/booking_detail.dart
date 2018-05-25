import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../app/model.dart';
import '../core/date.dart';
import 'actions.dart';
import 'model.dart';

class BookingDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookingDetailViewModel>(
      converter: (Store<AppState> store) {
        final selectedDate = store.state.workTimeTracker.selectedDate;
        return BookingDetailViewModel(
            selectedDate,
            store.state.workTimeTracker.bookings[selectedDate],
            (newTime) =>
                store.dispatch(WorkTimeChangeStartTime(selectedDate, newTime)),
            (newTime) =>
                store.dispatch(WorkTimeChangeEndTime(selectedDate, newTime)),
            (isWorkDay) => store
                .dispatch(WorkTimeChangeIsWorkDay(selectedDate, isWorkDay)));
      },
      builder: (BuildContext context, BookingDetailViewModel vm) {
        TimeOfDay starTime;
        TimeOfDay endTime;
        if (vm.booking?.start != null) {
          starTime = TimeOfDay.fromDateTime(vm.booking.start);
        }
        if (vm.booking?.end != null) {
          endTime = TimeOfDay.fromDateTime(vm.booking.end);
        }
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                  DateFormat("yMMMMEEEEd").format(vm.selectedDay.toDateTime()),
                  style: Theme.of(context).textTheme.subhead),
            ),
            Divider(),
            _buildTimeSelector(starTime, TimeOfDay(hour: 8, minute: 0), "Start",
                vm.changeStartTime, context),
            _buildTimeSelector(endTime, TimeOfDay(hour: 17, minute: 0), "End",
                vm.changeEndTime, context),
            Divider(),
            Card(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Work day?'),
                  Switch(
                      activeColor: Theme.of(context).primaryColor,
                      value: vm.booking?.isWorkDay ?? true,
                      onChanged: vm.changeIsWorkDay),
                ],
              ),
            ))
          ],
        );
      },
    );
  }

  Widget _buildTimeSelector(
      TimeOfDay displayTime,
      TimeOfDay fallbackTime,
      String fallbackText,
      void Function(TimeOfDay newTime) callback,
      BuildContext context) {
    String displayText = fallbackText;
    TimeOfDay initialTime = fallbackTime;
    if (displayTime != null) {
      displayText = displayTime.format(context);
      initialTime = displayTime;
    }
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Text(displayText,
                    style: Theme.of(context).textTheme.subhead)),
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.black54,
              onPressed: onEditButtonPressed(context, initialTime, callback),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline),
              color: Colors.red[900],
              onPressed: onDeleteButtonPressed(callback),
            ),
          ],
        ),
      ),
    );
  }

  onEditButtonPressed(BuildContext context, TimeOfDay initialTime,
      void changeTime(TimeOfDay time)) {
    return () {
      showTimePicker(context: context, initialTime: initialTime)
          .then((time) => changeTime(time));
    };
  }

  onDeleteButtonPressed(void changeTime(TimeOfDay time)) {
    return () {
      changeTime(null);
    };
  }
}

@immutable
class BookingDetailViewModel {
  final Date selectedDay;
  final Booking booking;
  final void Function(TimeOfDay newTime) changeStartTime;
  final void Function(TimeOfDay newTime) changeEndTime;
  final void Function(bool isWorkDay) changeIsWorkDay;

  BookingDetailViewModel(this.selectedDay, this.booking, this.changeStartTime,
      this.changeEndTime, this.changeIsWorkDay);
}
