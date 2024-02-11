import 'package:flutter/material.dart';
import 'package:flutter_application_2/Note.dart';
import 'package:flutter_application_2/NoteDataBase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';


class SingleDayCalendar2 extends StatefulWidget{

  // Aggiungi il parametro noteDB
  const SingleDayCalendar2({ super.key, required this.noteDB });
  // Usa il parametro noteDB per accedere al provider
  final NoteDataBase noteDB;
  @override
  State<SingleDayCalendar2> createState() => _SingleDayCalendarState();


}


class _SingleDayCalendarState extends State<SingleDayCalendar2>  {

  final textController = TextEditingController();


  @override
  Widget build( context) {
    // Usa widget.noteDB per accedere al provider
    List<Note> currentNotes = widget.noteDB.currentNotes;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,66,66,66),
      appBar: AppBar(
        title: Text("TITOLO"), 
        ),
      floatingActionButton: 
      FloatingActionButton(
        onPressed: createNotes,
        child: const Icon(Icons.add)
      ),
      body:  ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context,index)
        {
          return ListTile(
            title: Text(currentNotes[index].text),
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

            // Usa widget.noteDB per accedere al provider
            widget.noteDB.addNote(textController.text, DateTime.now());
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
    // Usa widget.noteDB per accedere al provider
    widget.noteDB.fetchNotes();
  }

}