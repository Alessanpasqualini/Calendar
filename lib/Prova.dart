import 'package:flutter/material.dart';
import 'package:flutter_application_2/Note.dart';
import 'package:flutter_application_2/NoteDB.dart';
import 'package:provider/provider.dart';

class SingleDayCalendar2 extends StatefulWidget{

  const SingleDayCalendar2({ super.key });
  @override
  State<SingleDayCalendar2> createState() => _SingleDayCalendarState();


}

class _SingleDayCalendarState extends State<SingleDayCalendar2>  {

  final textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
        //final NodeDB = NoteDB.initialize();
    //final noteDB = context.read<NoteDB>();
    //List<Note> currentNotes = noteDB.currentNotes;
     return   Scaffold(

     );
  }
  

  
  @override
  void initState()
  {
    super.initState();
    readNotes();
  }

  void createNotes()
  {
    showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: (){

            context.read<NoteDB>().addNote(textController.text, DateTime.now());
            Navigator.pop(context);

            },
            child: const Text("Creata"),
          )
        ],
      ),
    );
  }
  
  void readNotes()
  {
    //context.watch<NoteDB>().fetchNotes();
  }
}