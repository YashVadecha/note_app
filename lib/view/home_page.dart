import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:note_app/DBProvider.dart';
import 'package:note_app/notes_model.dart';
import 'package:note_app/view/add_edit_notes_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}
class HomePageState extends State<StatefulWidget> with SingleTickerProviderStateMixin{

  /// Date Controller
  DateFormat mFormate =DateFormat.yMMMd();

  TextEditingController titlecontroller =TextEditingController();
  TextEditingController desccontroller =TextEditingController();

 static List<NotesModel> allNotes=[];

  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getIntitNote();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightGreen,
      ),
      body: Consumer<DBProvider>(
        builder: (_,provider,__){
          List<NotesModel> allNotes =provider.getAllNotes();
          return allNotes.isNotEmpty?AnimationLimiter(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (_,index){
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 2,
                  duration: const Duration(milliseconds: 300),
                  child: SlideAnimation(
                    verticalOffset: 50,
                    child: ScaleAnimation(
                      delay: const Duration(milliseconds: 200),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditNotesPage(isUpdate: true,sno: allNotes[index].sno!,title: allNotes[index].title,desc: allNotes[index].desc,),));
                        },
                        child: Padding(

                          /// Body Part of Notes
                          padding: const EdgeInsets.only(top: 8,bottom: 8,right: 7,left: 7),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [const BoxShadow(color: Colors.grey)],
                              border: Border.all(color: Colors.grey,width: 1),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            width: 300,
                            height: 300,
                            child: GridTile(
                              header: IconButton(onPressed: (){
                                provider.deleteNotes(allNotes[index].sno!);
                              }, icon: const Icon(Icons.delete_forever,color: Colors.lightGreen,size: 30,),alignment: Alignment.topRight,),

                              ///Notes Created Date-Time...
                              footer: Text(mFormate.format(DateTime.fromMillisecondsSinceEpoch(int.parse(allNotes[index].created_at)))),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                    width: 300,
                                    height: 170,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        /// Title
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          allNotes[index].title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        /// Description
                                        Text(
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          allNotes[index].desc,style: const TextStyle(fontSize: 16),),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount:allNotes.length,
            ),
          ): Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/notes.png',height: 300,),
              const Text("Ops. no Notes Found!!",style: TextStyle(fontSize: 20),),
            ],
          ),);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            titlecontroller.clear();
            desccontroller.clear();
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditNotesPage(),));
          },
        tooltip: "Add Note",
        backgroundColor: Colors.lightGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
