import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDataBase extends ChangeNotifier{

  static late final Isar isar;
  final List<Note> currentNotes = [];
  final List<int> dayWithNote = [];

  static Future<void> initialize() async 
  {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema], 
      directory: dir.path,
      );
  }

//Write
  Future<void> addNote(String textFromUser,DateTime date) async
  {
    final newNote = Note();
      newNote.text = textFromUser;
      newNote.date = date;

    await isar.writeTxn(() => isar.notes.put(newNote));
    await fetchNotes(date);

  }

  
  // READ
  Future<void> fetchNotes(DateTime date) async
  {
    List<Note> fetchedNotes = await isar.notes.filter().dateEqualTo(date).findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> updateNotes(Note note,String newText) async
  {
    final existingNote = await isar.notes.get(note.id);
    if(existingNote==null) return;

    existingNote.text = newText;
    await isar.writeTxn(() => isar.notes.put(existingNote));
    await fetchNotes(note.date);

  }

  Future<void> deleteNotes(Note note) async
  {
      final existingNote = await isar.notes.get(note.id);
      if(existingNote==null) return;
      await isar.writeTxn(() => isar.notes.delete(note.id));
      await fetchNotes(note.date);
  }

  Future<bool> haveNote(DateTime date) async
  {
    Note? first = await isar.notes.filter().dateEqualTo(date).findFirst();
    return first!= null;
  }

  Future<void> updateDayWithNotes(DateTime date) async
  {

    dayWithNote.clear();
    for(int i = 0 ;i< DateTime(date.year,date.month+1,0).day;i++)
    {
        List<Note> findNotes = await isar.notes.filter().dateEqualTo(DateTime(date.year,date.month,i)).findAll();
      if(findNotes.isNotEmpty)
      {
        dayWithNote.add(i);
      }
    }
 
    notifyListeners();
  }

}
