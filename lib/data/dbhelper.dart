import 'dart:io';
import 'package:note_app/notes_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {

  ///Single Instonces..
  Dbhelper._();
   static Dbhelper getInstance()=>Dbhelper._();

   static final String TABLE_NOTE ="notes";
   static final String  COLUMN_SNO ="s_no";
   static final String  COLUMN_TITLE ="title";
   static final String  COLUMN_DESC ="desc";
   static final String  COLUMN_CREATED_AT ="created";

   ///Global DB...
    Database? mdb;

    ///getDB..
    Future<Database> getDB()async{
      mdb??=await openDB();
      return mdb!;
    }

    ///openDB...
    Future<Database> openDB() async{
      Directory appDirc =await getApplicationDocumentsDirectory();
      String dbPath =join(appDirc.path,"notesapp.db");
     return await openDatabase(dbPath,onCreate:(db,version){
        db.execute("create table $TABLE_NOTE ($COLUMN_SNO integer primary key autoincrement,$COLUMN_TITLE text,$COLUMN_DESC text,$COLUMN_CREATED_AT text)");
        //...
      },version: 1 );
    }
    ///ALl Queries..

  ///Insert Data...
  ///From modal Tomap...
   Future<bool> addNotes({required NotesModel newNotes})async {
      var mDB =await getDB();
     int rowEffected = await mDB.insert(TABLE_NOTE, newNotes.toMap());
     return rowEffected>0;
    }
    ///Fetch All Data..
  ///from map to Model..
   Future<List<NotesModel>> fetchNotes()async{
      var mDB =await getDB();
    var data = await mDB.query(TABLE_NOTE);
    List<NotesModel> mNotes=[];
    for(Map<String,dynamic> eachData in data){
      mNotes.add(NotesModel.fromMap(eachData));
    }
    return mNotes;
  }

  ///Update...
 Future<bool> updateNote({required NotesModel updatedNotes, required int sno})async{
      var mDB =await getDB();
    int rowEffected = await mDB.update(TABLE_NOTE,updatedNotes.toMap() ,where: "$COLUMN_SNO=$sno");
    return rowEffected>0;
  }

  ///Delete Notes
  Future<bool> deleteNote({required int sno}) async{
      var mDB =await getDB();
     int rowEffected = await mDB.delete(TABLE_NOTE,
        where: "$COLUMN_SNO=$sno");
     return rowEffected>0;
  }

}