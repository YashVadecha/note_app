import 'package:flutter/material.dart';
import 'package:note_app/DBProvider.dart';
import 'package:note_app/notes_model.dart';
import 'package:provider/provider.dart';

class AddEditNotesPage extends StatefulWidget{
  int sno;
  bool isUpdate;
  String title,desc;
  AddEditNotesPage({this.isUpdate=false,this.sno=0,this.title="",this.desc=""});

  @override
  State<AddEditNotesPage> createState() => _AddEditNotesPageState();
}

class _AddEditNotesPageState extends State<AddEditNotesPage> {

  TextEditingController titlecontroller =TextEditingController();
  TextEditingController desccontroller =TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(widget.isUpdate){
      titlecontroller.text=widget.title;
      desccontroller.text=widget.desc;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: ()async{
                if(titlecontroller.text.isNotEmpty&&desccontroller.text.isNotEmpty){
                  if(widget.isUpdate){
                    context.read<DBProvider>().updateNotes(NotesModel(title: titlecontroller.text, desc: desccontroller.text,created_at: DateTime.now().millisecondsSinceEpoch.toString()), widget.sno);
                    Navigator.pop(context);
                  }
                  else{
                    context.read<DBProvider>().addNotes(NotesModel(title: titlecontroller.text, desc: desccontroller.text,created_at: DateTime.now().millisecondsSinceEpoch.toString()));
                    Navigator.pop(context);
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text(widget.isUpdate?"Edit":"Add",style: const TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              /// Notes Title..
              SizedBox(
                width: double.infinity,
                height: 150,
                child: TextField(
                  controller: titlecontroller,
                  expands: true,
                  maxLines: null,
                  style: const TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter The Title...",
                  ),
                ),
              ),
              /// Notes Description..
              Expanded(
                child: SizedBox(
                  child: TextField(
                    controller: desccontroller,
                    style: const TextStyle(fontSize: 21),
                    expands: true,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter The Description..."
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

