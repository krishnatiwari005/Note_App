import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';             //added 
const String notesBoxName = 'notesBox';      // added
class NotesNotifier extends ChangeNotifier{

  List notesList =[];
   late Box<String> _notesBox;              //added

  NotesNotifier(){
    _initialize(); 
  }
  void _initialize() async {                 //added
    _notesBox = Hive.box<String>(notesBoxName);
    notesList = _notesBox.values.toList(); // Load existing notes
    notifyListeners();
  }

  void onSaveNote(String note)
  {
    _notesBox.add(note);                      //added
    notesList.add(note);
    notifyListeners();
  }

  void onRemoveNote(int index){
    _notesBox.deleteAt(index);                        //added
    notesList.removeAt(index);
    notifyListeners();
  }

}

final notesProvider =ChangeNotifierProvider<NotesNotifier>((ref) {
  return NotesNotifier();
});