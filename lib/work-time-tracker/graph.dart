import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../app/model.dart';
import '../core/date.dart';
import 'model.dart';

class Graph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GraphViewModel>(
        converter: (Store<AppState> store) =>
            GraphViewModel(store.state.workTimeTracker.bookings),
        builder: (BuildContext context, GraphViewModel vm) {
          final data = vm.bookings.entries
              .where((entry) => entry.value.isFullyBooked())
              .toList();
          return charts.TimeSeriesChart(
            [
              charts.Series<MapEntry<Date, Booking>, DateTime>(
                id: 'Start',
                domainFn: (datum, int index) => datum.key.toDateTime(),
                measureFn: (datum, int index) =>
                    datum.value.start.hour * 100 + datum.value.start.minute,
                data: data,
              ),
              charts.Series<MapEntry<Date, Booking>, DateTime>(
                id: 'End',
                domainFn: (datum, int index) => datum.key.toDateTime(),
                measureFn: (datum, int index) =>
                    datum.value.end.hour * 100 + datum.value.end.minute,
                data: data,
              )
            ],
            behaviors: [
              charts.SeriesLegend(position: charts.BehaviorPosition.bottom)
            ],
          );
        });
  }
}

class GraphViewModel {
  final Map<Date, Booking> bookings;

  GraphViewModel(this.bookings);
}
