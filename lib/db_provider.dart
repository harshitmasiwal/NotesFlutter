import 'package:flutter/material.dart';
import 'package:notes/data/DBHelper.dart';

class DbProvider extends ChangeNotifier {
  Dbhelper dbhelper;
  DbProvider({required this.dbhelper});
  List<Map<String, dynamic>> _mdata = [];

  void addNote(String title, String desc) async {
    bool check = await dbhelper.addNote(mTitle: title, mDesc: desc);

    if (check) {
      _mdata = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }

  void updateNote(String title, String desc, int sno) async {
    bool check = await dbhelper.updateNote(title: title, desc: desc, sno: sno);

    if (check) {
      _mdata = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }

  void deleteNote(int idx) async {
    bool check = await dbhelper.deleteNote(sno: idx);

    if (check) {
      _mdata = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }

  void deleteAllNotes() async {
    bool check = await dbhelper.deleteAllNotes();
      print('Deleted all notes: $check');

    if (check) {
      _mdata = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getNotes() => _mdata;

  void getInitialNotes() async {
    _mdata = await dbhelper.getAllNotes();
    notifyListeners();
  }
}
