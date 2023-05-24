import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tars/viewmodel/article_list_view_model.dart';
import 'Following.dart';
import 'HomePage.dart';
import 'Headlines.dart';
import 'Profile.dart';
import 'Search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => ArticleListViewModel(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _tabItems = [HomePage(), Headlines(), FollowingPage()];
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              centerTitle: true,
              backgroundColor: Colors.black,
              floating: true,
              snap: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SearchPage())),
                    icon: const Icon(Icons.search)),
              ),
              title: const Text(
                "Tars News",
                style:
                TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: IconButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Profile())),
                      icon: const Icon(Icons.account_circle_sharp)),
                ),
              ],
            ),
          ];
        },
        body: Center(
            child: _tabItems[_activePage]
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.cyan.shade800,
        buttonBackgroundColor: Colors.brown.shade900,
        color: Colors.black,
        height: 55.0,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.newspaper, size: 30, color: Colors.yellow),
          Icon(Icons.category_outlined, size: 30, color: Colors.yellow),
          Icon(Icons.star_border_outlined, size: 30, color: Colors.yellow),
        ],
        onTap: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
    );
  }
}
