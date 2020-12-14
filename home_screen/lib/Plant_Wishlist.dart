import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class Plant_Wishlist extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Wish-list'),
        backgroundColor: Colors.green,),
        body: Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment(0,-0.1),
                  child: Icon((Icons.local_florist),
                    size: 100,
                    color: Colors.grey,)
              ),
              Align(
                  alignment: Alignment(0,0.1),
                  child: const Text('Press the green button to get started!',
                      style: TextStyle(color: Colors.grey))),
              Align(
                  alignment: Alignment(0.8,0.9),
                  child: FloatingActionButton(onPressed: () {
                  },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.green,
                  )
              ),
            ]
        )
    );
  }
}

