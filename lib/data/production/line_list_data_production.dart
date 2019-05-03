import 'package:line_monitor/models/line_stat.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class ProdLineStatRepository implements LineStatRepository {


  @override
  Future<List<LineStat>> fetchLineStatFromFirebase() async {
    List<LineStat> lineStat = new List();
    final lineList = FirebaseDatabase.instance
        .reference()
        .child('lineRecord')
        .child('current');

    lineList.onChildAdded.listen((event) {
      print("Data Added");
      lineStat.add(new LineStat.fromSnapshot(event.snapshot));
    });


    lineList.onChildChanged.listen((event){
      print("Data Changed");


      var oldNoteValue = lineStat.singleWhere((items) => items.key == event.snapshot.key);
      print("Old Data : ${oldNoteValue.name}");
      print("New Data : ${LineStat.fromSnapshot(event.snapshot).name}");
      lineStat[lineStat.indexOf(oldNoteValue)] = new LineStat.fromSnapshot(event.snapshot);


    });


    return lineStat.toList();
  }


}
