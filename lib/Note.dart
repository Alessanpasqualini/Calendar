import 'package:isar/isar.dart';

part 'Note.g.dart';
@Collection()
class Note{

  Id id = Isar.autoIncrement;
  late String text;
  late DateTime date;

}