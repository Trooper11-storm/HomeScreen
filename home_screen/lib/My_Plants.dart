import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class My_Plants extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Plants'),
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
            child: FloatingActionButton(onPressed: () {navigateToSearchPage(context);},
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
          )
          ),
        ]
      )
    );
  }
}

Future navigateToSearchPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
}

class SearchPage extends StatelessWidget {
  // This widget is the root of the search page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SearchBarController<Post> _searchBarController = SearchBarController();


  Future<List<Post>> _getALlPosts(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));


    List<Post> posts = [];

    var random = new Random();
    for (int i = 0; i < 10; i++) {
      posts.add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<Post>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlPosts,
          searchBarController: _searchBarController,
          placeHolder: Text("placeholder"),
          cancellationWidget: Text("Cancel"),
          emptyWidget: Text("empty"),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
          header: Row(
            children: <Widget>[
              RaisedButton(
                child: Text("plant"),
                onPressed: () {
                  _searchBarController.sortList((Post a, Post b) {
                    return a.body.compareTo(b.body);
                  });
                },
              ),
            ],
          ),
          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Post post, int index) {
            return Container(
              color: Colors.green,
              child: ListTile(
                title: Text(post.title),
                isThreeLine: true,
                subtitle: Text(post.body),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Plant data"),
          ],
        ),
      ),
    );
  }
}

//Future<Plant> fetchPlant() async {
  //final response =
  //await http.get('https://trefle.io/api/v1/species/search?q=Jerusalem%20artichoke&limit=3&token=Hmdu-XqTVw-cQNvGp-qLuZpckmgvR7FjLLzFLmmu9Iw');
//}

