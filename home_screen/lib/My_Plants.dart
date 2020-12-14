import 'package:flutter/material.dart';
import 'main.dart';
import 'package:dio/dio.dart';

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


class SearchPage extends StatefulWidget {
  SearchPage({ Key key }) : super(key: key);
  @override
  SearchPageState createState() => new SearchPageState();

}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Enter Plant' );

  SearchPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
}

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Search Example' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await dio.get('https://swapi.co/api/people');
    List tempList = new List();
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }

}
