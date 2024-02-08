import 'package:flutter/material.dart';
import 'package:flutter_application_2/Note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDB extends ChangeNotifier{

  static late Isar isar;

  static Future<void> initialize() async 
  {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema], 
      directory: dir.path
      // ignore: avoid_print
      );
  }

  final List<Note> currentNotes = [];
//Write
  Future<void> addNote(String textFromUser,DateTime date) async
  {
    final newNote = Note()..text = textFromUser;
    newNote..date = date;

    await isar.writeTxn(() => isar.notes.put(newNote));
  }

  // READ
  Future<void> fetchNote() async
  {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
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
      await fetchNote();
  }
}