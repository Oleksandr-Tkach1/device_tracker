// import 'dart:async';
// import 'package:carp_background_location/carp_background_location.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class Geolocation extends StatefulWidget {
//   const Geolocation({Key? key}) : super(key: key);
//
//   @override
//   State<Geolocation> createState() => _GeolocationState();
// }
//
// enum LocationStatus { UNKNOWN, INITIALIZED, RUNNING, STOPPED }
//
// String dtoToString(LocationDto dto) =>
//     'Location ${dto.latitude}, ${dto.longitude} at ${DateTime.fromMillisecondsSinceEpoch(dto.time ~/ 1)}';
//
// Widget dtoWidget(LocationDto? dto) {
//   if (dto == null)
//     return Text("No location yet");
//   else
//     return Column(
//       children: <Widget>[
//         Text(
//           '${dto.latitude}, ${dto.longitude}',
//         ),
//         Text(
//           '@',
//         ),
//         Text('${DateTime.fromMillisecondsSinceEpoch(dto.time ~/ 1)}')
//       ],
//     );
// }
//
// class _GeolocationState extends State<Geolocation> {
//   String logStr = '';
//   LocationDto? lastLocation;
//   DateTime? lastTimeLocation;
//   Stream<LocationDto>? locationStream;
//   StreamSubscription<LocationDto>? locationSubscription;
//   LocationStatus _status = LocationStatus.UNKNOWN;
//
//   @override
//   void initState() {
//     super.initState();
//
//     LocationManager().interval = 1;
//     LocationManager().distanceFilter = 0;
//     LocationManager().notificationTitle = 'CARP Location Example';
//     LocationManager().notificationMsg = 'CARP is tracking your location';
//     locationStream = LocationManager().locationStream;
//
//     _status = LocationStatus.INITIALIZED;
//   }
//
//   void getCurrentLocation() async =>
//       onData(await LocationManager().getCurrentLocation());
//
//   void onData(LocationDto dto) {
//     // print(dtoToString(dto));
//     print(dto);
//     setState(() {
//       lastLocation = dto;
//       lastTimeLocation = DateTime.now();
//     });
//   }
//
//   /// Is "location always" permission granted?
//   Future<bool> isLocationAlwaysGranted() async =>
//       await Permission.locationAlways.isGranted;
//
//   /// Tries to ask for "location always" permissions from the user.
//   /// Returns `true` if successful, `false` othervise.
//   Future<bool> askForLocationAlwaysPermission() async {
//     bool granted = await Permission.locationAlways.isGranted;
//
//     if (!granted) {
//       granted =
//           await Permission.locationAlways.request() == PermissionStatus.granted;
//     }
//
//     return granted;
//   }
//
//   /// Start listening to location events.
//   void start() async {
//     // ask for location permissions, if not already granted
//     if (!await isLocationAlwaysGranted())
//       await askForLocationAlwaysPermission();
//
//     locationSubscription?.cancel();
//     locationSubscription = locationStream?.listen(onData);
//     await LocationManager().start();
//     setState(() {
//       _status = LocationStatus.RUNNING;
//     });
//   }
//
//   void stop() {
//     locationSubscription?.cancel();
//     LocationManager().stop();
//     setState(() {
//       _status = LocationStatus.STOPPED;
//     });
//   }
//
//   Widget stopButton() => SizedBox(
//     width: double.maxFinite,
//     child: ElevatedButton(
//       child: const Text('STOP'),
//       onPressed: stop,
//     ),
//   );
//
//   Widget startButton() => SizedBox(
//     width: double.maxFinite,
//     child: ElevatedButton(
//       child: const Text('START'),
//       onPressed: start,
//     ),
//   );
//
//   Widget status() => Text("Status: ${_status.toString().split('.').last}");
//
//   Widget lastLoc() => Text(
//       lastLocation != null
//           ? dtoToString(lastLocation!)
//           : 'Unknown last location',
//       textAlign: TextAlign.center);
//
//   Widget currentLocationButton() => SizedBox(
//     width: double.maxFinite,
//     child: ElevatedButton(
//       child: const Text('CURRENT LOCATION'),
//       onPressed: getCurrentLocation,
//     ),
//   );
//
//   @override
//   void dispose() => super.dispose();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('CARP Background Location'),
//         ),
//         body: Container(
//           width: double.maxFinite,
//           padding: const EdgeInsets.all(22),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 startButton(),
//                 stopButton(),
//                 currentLocationButton(),
//                 Divider(),
//                 status(),
//                 Divider(),
//                 dtoWidget(lastLocation),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
