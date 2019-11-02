import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final _key = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      // home: HomeScreen(),
      initialRoute: "/",
      routes: {
        '/': (context) => HomeScreen(),
        '/post': (context) => PostScreen()
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.perm_identity),
            onPressed: () {
              _key.currentState.openDrawer();
            },
          ),
          title: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                Text(
                  "Search",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Text(
                "Home",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Text(
                "Popular",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              )
            ],
          ),
          elevation: 1,
          titleSpacing: 1,
        ),
        drawer: Drawer(
          child: Center(
            child: RaisedButton(
              child: Text("Close Drawer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomeTab(),
            Center(
              child: Text("Popular"),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.blur_circular), title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text("")),
            BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit),
                ),
                title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.message), title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.email), title: Text("")),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () => Navigator.of(context).pushNamed('/post'),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.face),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("r/something"),
                    )),
                    Icon(Icons.more_vert)
                  ],
                ),
                Text("Some text will be written here blah blah blah......"),
                Container(
                  height: 200,
                  color: Colors.grey[100],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.grey,
                          ),
                          Text("Vote"),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.message,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8),
                          Text("2"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.reply,
                            color: Colors.grey,
                          ),
                          Text("Share"),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool loading = true;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.blue),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            Icon(Icons.bookmark),
            Icon(Icons.more_vert),
          ],
        ),
        body: Center(
          child: loading
              ? CircularProgressIndicator()
              : Text("Pretend this is a Post"),
        ),
      ),
    );
  }
}
