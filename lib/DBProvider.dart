import 'package:flutter/cupertino.dart';
import 'package:note_app/data/dbhelper.dart';
import 'notes_model.dart';

class DBProvider extends ChangeNotifier{
  Dbhelper dbhelper;
  DBProvider({required this.dbhelper});
  List<NotesModel> _mNotes=[];

  ///events...
  void addNotes(NotesModel newnote)async{
   bool isAdd = await dbhelper.addNotes(newNotes: newnote);
   if(isAdd){
     _mNotes =await dbhelper.fetchNotes();
    notifyListeners();
   }
  }

  void updateNotes(NotesModel uNotes,int index)async{
    bool isUpdate= await dbhelper.updateNote(updatedNotes: uNotes, sno: index);
    if(isUpdate){
      _mNotes =await dbhelper.fetchNotes();
      notifyListeners();
    }
  }
  void deleteNotes(int index)async{
    bool isDelete =await dbhelper.deleteNote(sno: index);
    if(isDelete){
      _mNotes = await dbhelper.fetchNotes();
      notifyListeners();
    }
  }

  void getIntitNote() async{
    _mNotes=await dbhelper.fetchNotes();
    notifyListeners();
  }

  List<NotesModel> getAllNotes()=>_mNotes;
}