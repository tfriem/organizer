import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../app/model.dart';
import '../l10n.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OverviewViewModel>(
      converter: (Store<AppState> store) {
        final fullyBookedTimes = store.state.workTimeTracker.bookings.values
            .where((booking) => booking.isFullyBooked());

        final startTimes = fullyBookedTimes.map((booking) => Duration(
            hours: booking.start.hour,
            minutes: booking.start.minute,
            seconds: booking.start.second));
        final endTimes = fullyBookedTimes.map((booking) => Duration(
            hours: booking.end.hour,
            minutes: booking.end.minute,
            seconds: booking.end.second));
        final workDurations = fullyBookedTimes.map((booking) =>
            booking.end.difference(booking.start) - Duration(minutes: 30));

        final averageStartTime = _calculateAverageTime(startTimes.toList());
        final averageEndTime = _calculateAverageTime(endTimes.toList());
        final averageWorkTime = _calculateAverageTime(workDurations.toList());
        final workSaldo =
            (averageWorkTime - Duration(hours: 8)) * fullyBookedTimes.length;

        return OverviewViewModel(fullyBookedTimes.length, averageStartTime,
            averageEndTime, averageWorkTime, workSaldo);
      },
      builder: (BuildContext context, OverviewViewModel vm) {
        return Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              OrganizerLocalization
                  .of(context)
                  .overviewBookedDays(vm.bookedDays),
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              OrganizerLocalization.of(context).overviewAverageStarting(
                  _formatDuration(vm.averageStartTime)),
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              OrganizerLocalization
                  .of(context)
                  .overviewAverageEnd(_formatDuration(vm.averageEndTime)),
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
                OrganizerLocalization.of(context).overviewAverageDuration(
                    _formatDuration(vm.averageWorkDuration)),
                style: Theme.of(context).textTheme.subhead),
          ),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                  OrganizerLocalization
                      .of(context)
                      .overviewDurationSum(_formatDuration(vm.workSaldo.abs())),
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
