import 'package:flutter/material.dart';
import 'package:flutter_application_2/Note.dart';
import 'package:flutter_application_2/NoteDB.dart';
import 'package:provider/provider.dart';

class SingleDayCalendar2 extends StatefulWidget{

  const SingleDayCalendar2({ super.key });
  @override
  State createState() => _SingleDayCalendarPage();


}

class _SingleDayCalendarPage extends State<SingleDayCalendar2>  {

  final textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    //final noteDB = context.watch<NoteDB>();

    //List<Note> currentNotes = noteDB.currentNotes;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,66,66,66),
      appBar: AppBar(
        title: Text("w"), 
        ),
      floatingActionButton: 
      FloatingActionButton(
        onPressed: createNotes,
        child: const Icon(Icons.add)
      ),
      body:  ListView.builder(
        itemCount:1,
        itemBuilder: (context,index)
        {
          final note = "currentNotes[index];";
          return ListTile(
            title: Text(note),
          );
        }, 
      ),
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

           // context.read<NoteDB>().addNote(textController.text, DateTime.now());
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
    context.watch<NoteDB>().fetchNote();
  }
}