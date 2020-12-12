import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = 'MyGarden';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}





class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,),
      body: Center(child: Text('To be filled in...')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment:Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35,
                    )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text('User', style: TextStyle(color: Colors.white, fontSize:30)))
                ]
              )
            ),
            ListTile(
              title: Text('My plants',  style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.local_florist, size: 40),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Plant wish-list', style: TextStyle(fontSize: 15)),
                leading: Icon(Icons.list, size: 40),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Calendar', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.calendar_today, size: 40),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Notifications', style: TextStyle(fontSize: 15)),
                leading: Icon(Icons.notifications, size: 40),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Profile', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.account_circle, size: 40),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Logout', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.exit_to_app, size: 40),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
