import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:line_monitor/view/fragment/map_view.dart';
import 'package:line_monitor/view/fragment/line_list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    LineList(),
    MapView(),
    MapView(),
    MapView(),
    MapView(),
  ];

  final List<String> _header = [
    'Dashboard',
    'History',
    'Line Maps',
    'Leakage',
    'Account'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData.light().canvasColor,
        leading: Icon(
          Icons.border_clear,
          color: Colors.grey[700],
        ),
        elevation: 0,
        centerTitle: false,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 24),
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey[700],
            ),
          )
        ],
        title: Text(
          _header[_currentIndex],
          style: TextStyle(
              fontFamily: 'sans-francisco',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: ThemeData().accentColor,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.white,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.white))),
          // sets the inactive color of the `BottomNavigationBar`
          child: new BottomNavigationBar(
            onTap: (index){
              onTabTapped(index);
            }, // new
            currentIndex: _currentIndex, // new
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.line_style),
                title: Text('Home',style: TextStyle(fontSize: 0),),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.history),
                title: Text('Home',style: TextStyle(fontSize: 0),),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text('Home',style: TextStyle(fontSize: 0),),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.warning),
                title: Text('Home',style: TextStyle(fontSize: 0),),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.supervisor_account),
                title: Text('Home',style: TextStyle(fontSize: 0),),
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
      ),
      body: _children[_currentIndex],
    );
  }

//  Tab Adapter
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

//CurvedNavigationBar(
//index: 0,
//color: ThemeData.light().bottomAppBarColor,
//backgroundColor: ThemeData().accentColor,
//items: <Widget>[
//Icon(Icons.list, size: 30),
//Icon(Icons.history, size: 30),
//Icon(
//Icons.map,
//size: 30,
//),
//Icon(Icons.warning, size: 30),
//Icon(Icons.supervisor_account, size: 30)
//],
//onTap: (index) {
//onTabTapped(index);
//},

