import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class Calendar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: Colors.green,),
    );
  }
}