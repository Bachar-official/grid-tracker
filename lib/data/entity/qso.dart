import 'package:fluent_ui/fluent_ui.dart';
import 'package:grid_tracker/utils/utils.dart';
import 'package:gridlocator/gridlocator.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class QSO {
  final DateTime time;
  final String callsign;
  final String qth;

  const QSO({required this.callsign, required this.qth, required this.time});

  double? _getDistance({required String myQth, bool inKilometers = true}) {
    if (!isQTH(qth) || myQth == '') {
      return null;
    }
    String localQth = qth;
    if (qth.length == 4) {
      localQth += 'll';
    }
    if (myQth.length == 4) {
      myQth += 'll';
    }
    final point = Gridlocator.decode(localQth);
    final myPoint = Gridlocator.decode(myQth);
    Distance distance = const Distance();
    return distance.as(
        inKilometers ? LengthUnit.Kilometer : LengthUnit.Mile,
        LatLng(point.latitude, point.longitude),
        LatLng(myPoint.latitude, myPoint.longitude));
  }

  TableRow toTableRow({required String myQth, bool inKilometers = true}) =>
      TableRow(children: [
        Center(
          child: Text(callsign),
        ),
        Center(
          child: Text(qth),
        ),
        Center(
          child: Text(_getDistance(myQth: myQth, inKilometers: inKilometers)
              .toString()),
        ),
        Center(child: Text(time.toLocal().toString())),
      ]);
}
