// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

final _key = GlobalKey<ScaffoldState>();
final dio = Dio(BaseOptions(baseUrl: 'https://dummyreddit.glitch.me'));

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
          currentIndex: 0,
          onTap: (index) {
            if (index == 2) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Theme(
                    data: ThemeData.dark(),
                    child: DefaultTextStyle(
                      style: TextStyle(color: Colors.white),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.blue
                            // border: RoundedRectangleBorder()
                            ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Post to Reddit"),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(4, (i) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.device_unknown,
                                        ),
                                        onPressed: () {},
                                      ),
                                      Text("????")
                                    ],
                                  );
                                })),
                            CloseButton() // inbuilt
                          ],
                        ),
                      ),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }
          },
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
        return Card(
          child: FutureBuilder(
            future: dio.get('/posts', queryParameters: {'index': i}),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              // snapshot.data has a dio response object
              Response response = snapshot.data;
              Map<String, dynamic> data = response.data;

              return InkWell(
                onTap: () => Navigator.of(context).pushNamed('/post'),
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
                          child: Text("r/${data['by']}"),
                        )),
                        Icon(Icons.more_vert)
                      ],
                    ),
                    Text(data['description']),
                    Container(
                      height: 200,
                      color: Colors.grey[100],
                      child: Image.network(
                        data['image'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
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
                                Text(data['comments'].toString()),
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
                      ),
                    )
                  ],
                ),
              );
            },
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
      if (mounted)
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
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
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
