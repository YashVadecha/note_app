import 'package:note_app/data/dbhelper.dart';

class NotesModel{
  int? sno;
  String title,desc;
  String created_at;
  NotesModel({this.sno,required this.title,required this.desc,required this.created_at});

  ///fromMap to Model
  factory NotesModel.fromMap(Map<String,dynamic> map)=>NotesModel(
        sno: map[Dbhelper.COLUMN_SNO],
        title: map[Dbhelper.COLUMN_TITLE],
        desc: map[Dbhelper.COLUMN_DESC],
        created_at: map[Dbhelper.COLUMN_CREATED_AT]
  );

///FromModel to map
 Map<String,dynamic> toMap()=>{
   Dbhelper.COLUMN_TITLE:title,
   Dbhelper.COLUMN_DESC:desc,
   Dbhelper.COLUMN_CREATED_AT:created_at
 };
}
