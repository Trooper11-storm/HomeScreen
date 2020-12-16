import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }


  return await Geolocator.getCurrentPosition();
}

class Weather extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Plants'),
        backgroundColor: Colors.green,),
      body: FlatButton(
        child: Text('Run Locator'),
        onPressed: () async {
          var value = await _determinePosition();
          print (value);
        },
      )
    );
  }

}
