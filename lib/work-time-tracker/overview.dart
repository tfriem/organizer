import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../app/model.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OverviewViewModel>(
      converter: (Store<AppState> store) {
        final bookedTimes = store.state.workTimeTracker.bookings.values;

        final startTimes = bookedTimes.map((booking) => new Duration(
            hours: booking.start.hour,
            minutes: booking.start.minute,
            seconds: booking.start.second));
        final endTimes = bookedTimes.map((booking) => new Duration(
            hours: booking.end.hour,
            minutes: booking.end.minute,
            seconds: booking.end.second));
        final workDurations = bookedTimes.map((booking) =>
            booking.end.difference(booking.start) - Duration(minutes: 30));

        final averageStartTime = _calculateAverageTime(startTimes.toList());
        final averageEndTime = _calculateAverageTime(endTimes.toList());
        final averageWorkTime = _calculateAverageTime(workDurations.toList());
        final workSaldo =
            (averageWorkTime - Duration(hours: 8)) * bookedTimes.length;

        return OverviewViewModel(bookedTimes.length, averageStartTime,
            averageEndTime, averageWorkTime, workSaldo);
      },
      builder: (BuildContext context, OverviewViewModel vm) {
        return Column(children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Booked days: ${vm.bookedDays}',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Average starting time: ${_formatDuration(vm.averageStartTime)}',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Average ending time: ${_formatDuration(vm.averageEndTime)}',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
                'Average duration: ${_formatDuration(vm.averageWorkDuration)}',
                style: Theme.of(context).textTheme.subhead),
          ),
          new Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Saldo: ${_formatDuration(vm.workSaldo.abs())}',
                  style: TextStyle(
                      color: vm.workSaldo.isNegative
                          ? Colors.red
                          : Colors.green))),
        ]);
      },
    );
  }
}

Duration _calculateAverageTime(List<Duration> times) {
  if (times.isEmpty) {
    return Duration();
  }
  return times.fold(Duration(), (sum, time) => sum + time) ~/ times.length;
}

String _formatDuration(Duration duration) =>
    '${duration.inHours.toString().padLeft(2,'0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

@immutable
class OverviewViewModel {
  final int bookedDays;
  final Duration averageStartTime;
  final Duration averageEndTime;
  final Duration averageWorkDuration;
  final Duration workSaldo;

  OverviewViewModel(this.bookedDays, this.averageStartTime, this.averageEndTime,
      this.averageWorkDuration, this.workSaldo);
}
