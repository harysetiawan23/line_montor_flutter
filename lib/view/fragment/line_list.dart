import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//Line Stat
import 'package:line_monitor/models/line_stat.dart';
import 'package:line_monitor/modules/line_stat_presenter.dart';

//Activity
import 'package:line_monitor/view/fragment/map_view.dart';

class LineList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LineList();
  }
}

final lineList =
    FirebaseDatabase.instance.reference().child('lineRecord').child('current');

class _LineList extends State<LineList> {
  LineListPresenter _lineListPresenter;
  List<LineStat> _lineLists;

  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  @override
  void initState() {
    super.initState();

    _lineLists = new List<LineStat>();

    _onNoteAddedSubscription = lineList.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription = lineList.onChildChanged.listen(_onNoteUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _lineLists.length,
        itemBuilder: (context, i) {
          final LineStat _lineStat = _lineLists[i];

          return Container(
            margin: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
            child: Card(
              elevation: 16,
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
//                    Card Header
                    Container(
                      margin: EdgeInsets.only(bottom: 12, top: 6),
                      child: Row(
                        children: <Widget>[
//                        Items Icon
                          Expanded(
                            flex: 0.5.toInt(),
                            child: Icon(
                              Icons.storage,
                              color: Colors.blue,
                            ),
                          ),

//                        Line Name
                          Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              _lineStat.name,
                              style: TextStyle(
                                  fontFamily: 'sans-francisco',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),

//                    Lines
                    Container(
                      height: 0.5,
                      color: Colors.black12,
                    ),

//                    Card Content
                    Container(
                      padding:
                          EdgeInsets.only(left: 6, right: 6, bottom: 6, top: 12),
                      child: Row(
                        children: <Widget>[
//                          Kebocoran Debit
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Kebocoran Debit",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 6, bottom: 6),
                                        child: Text(
                                            "${_lineStat.flowRatio != null ? _lineStat.flowRatio * 100 : 0} %",
                                            style: TextStyle(
                                                color: Colors.blue[800],
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),

//                          Kebocoran Tekanan
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Tekanan Hilang",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 6, bottom: 6),
                                        child: Text(
                                            "${_lineStat.pressureRatio != null ? (_lineStat.pressureRatio < 1 ? _lineStat.pressureRatio*100:0).toStringAsFixed(1) : 0} %",
                                            style: TextStyle(
                                                color: Colors.blue[800],
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),

//                          Action Button
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: new RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.graphic_eq,
                                          color: Colors.white,
                                        ),
                                        const Text(
                                          '  More',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    color: Colors.deepOrange[600],
                                    elevation: 0,
                                    splashColor: Colors.blueGrey,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MapView()),
                                      );
                                    },
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
             ],
                ),
              ),
            ),
          );
        });
  }

  Widget _getSubtitle(double ratio) {
    TextSpan percentageChangeWidget;
    var newRatio = ratio != null ? ratio * 100 : 0;

    if (newRatio > 0) {
      percentageChangeWidget = new TextSpan(
          text: "${newRatio} %",
          style: TextStyle(
              color: Colors.red[800],
              fontSize: 22,
              fontWeight: FontWeight.bold));
    } else {
      percentageChangeWidget = new TextSpan(
          text: "0 %",
          style: TextStyle(
              color: Colors.green[800],
              fontSize: 22,
              fontWeight: FontWeight.bold));
    }

    return new RichText(text: percentageChangeWidget);
  }

  void _onNoteAdded(Event event) {
    setState(() {
      _lineLists.add(new LineStat.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue =
        _lineLists.singleWhere((note) => note.key == event.snapshot.key);
    setState(() {
      _lineLists[_lineLists.indexOf(oldNoteValue)] =
          new LineStat.fromSnapshot(event.snapshot);
    });
  }
}

//Widget test() {
//  return Container(
//    margin: EdgeInsets.only(left: 12, right: 12),
//    child: Card(
//      child: Padding(
//        padding: EdgeInsets.all(12),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Align(
//                alignment: Alignment.centerLeft,
//                child: Padding(
//                  padding: EdgeInsets.only(left: 6, bottom: 6, top: 6),
//                  child: Text(
//                    _lineStat.name,
//                    textAlign: TextAlign.left,
//                    style: TextStyle(fontWeight: FontWeight.w300),
//                  ),
//                )),
//            Card(
//              shape: RoundedRectangleBorder(
//                side: BorderSide(color: Colors.grey, width: 2),
//              ),
//              elevation: 0,
//              child: Padding(
//                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
//                  child: Row(
//                    children: <Widget>[
//                      CircleAvatar(
//                        child: Icon(Icons.wifi_tethering),
//                        backgroundColor: Colors.amber,
//                      ),
//                      Expanded(
//                        flex: 1.5.toInt(),
//                        child: Padding(
//                          padding: EdgeInsets.only(left: 12),
//                          child: Text(_lineStat.startNodeSN),
//                        ),
//                      ),
//                      Expanded(
//                        flex: 1,
//                        child: Padding(
//                          padding: EdgeInsets.only(right: 12),
//                          child: Align(
//                            alignment: Alignment.centerRight,
//                            child: Text(
//                              "${_lineStat.lastStartNodeFlow != null ? _lineStat.lastStartNodeFlow.toStringAsFixed(1) : 0} L / m",
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Expanded(
//                        flex: 1,
//                        child: Padding(
//                          padding: EdgeInsets.only(right: 12),
//                          child: Align(
//                            alignment: Alignment.centerRight,
//                            child: Text(
//                              "${_lineStat.lastStartNodePressure != null ? _lineStat.lastStartNodePressure.toStringAsFixed(1) : 0} bars",
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  )),
//            ),
//            Card(
//              shape: RoundedRectangleBorder(
//                side: BorderSide(color: Colors.grey, width: 2),
//              ),
//              elevation: 0,
//              child: Padding(
//                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
//                  child: Row(
//                    children: <Widget>[
//                      CircleAvatar(
//                        child: Icon(Icons.wifi_tethering),
//                        backgroundColor: Colors.amber,
//                      ),
//                      Expanded(
//                        flex: 1.5.toInt(),
//                        child: Padding(
//                          padding: EdgeInsets.only(left: 12),
//                          child: Text(_lineStat.endNodeSN),
//                        ),
//                      ),
//                      Expanded(
//                        flex: 1,
//                        child: Padding(
//                          padding: EdgeInsets.only(right: 12),
//                          child: Align(
//                            alignment: Alignment.centerRight,
//                            child: Text(
//                              "${_lineStat.lastEndNodeFlow != null ? _lineStat.lastEndNodeFlow.toStringAsFixed(1) : 0} L / m",
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Expanded(
//                        flex: 1,
//                        child: Padding(
//                          padding: EdgeInsets.only(right: 12),
//                          child: Align(
//                            alignment: Alignment.centerRight,
//                            child: Text(
//                              "${_lineStat.lastEndNodePressure != null ? _lineStat.lastEndNodePressure.toStringAsFixed(1) : 0} bars",
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  )),
//            ),
//            Row(
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[],
//            )
//          ],
//        ),
//      ),
//    ),
//  );
//}
