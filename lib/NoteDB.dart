import 'package:flutter/material.dart';
import 'package:flutter_application_2/Note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDB extends ChangeNotifier{

  static late final Isar isar;

  static Future<void> initialize() async 
  {
    final dir = await getApplicationDocumentsDirectory();
    if (isar!= null && isar.isOpen) return;
    isar = await Isar.open(
      [NoteSchema], 
      directory: dir.path,
      inspector: true,
      );
      if (isar.isOpen)
      {
        print(isar.directory.toString());
      }
  }

  final List<Note> currentNotes = [];
//Write
  Future<void> addNote(String textFromUser,DateTime date) async
  {
    final newNote = Note();
      newNote..text = textFromUser;
      //..date = date; // assegno il valore del parametro date al campo date del nuovo oggetto Note

    await isar.writeTxn(() => isar.notes.put(newNote));
  }

  
  // READ
  Future<void> fetchNotes() async
  {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> updateNotes(int id,String newText) async
  {
    final existingNote = await isar.notes.get(id);
    if(existingNote==null) return;

    existingNote.text = newText;
    await isar.writeTxn(() => isar.notes.put(existingNote));
  }

  Future<void> deleteNotes(int id) async
  {
      final existingNote = await isar.notes.get(id);
      if(existingNote==null) return;
      await isar.writeTxn(() => isar.notes.delete(id));
      await fetchNotes();
  }
}
