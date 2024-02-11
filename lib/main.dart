import 'package:flutter/material.dart';
import 'package:flutter_application_2/Calendar.dart';
import 'package:flutter_application_2/Note.dart';
import 'package:flutter_application_2/NoteDataBase.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// Nel main, usa context.read<NoteDB>() invece di context.watch<NoteDB>()
void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  NoteDataBase.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDataBase(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Usa context.read<NoteDB>() per leggere il valore del provider
    final noteDB = context.read<NoteDataBase>();
    return MaterialApp(
      locale: const Locale('it','IT'),
      localizationsDelegates:const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      MonthYearPickerLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.varela().fontFamily,
        colorScheme:const ColorScheme.dark(
          primary: Color.fromARGB(255, 227, 227, 227),
          secondary: Color.fromARGB(255, 227, 227, 227)
        ),
        useMaterial3: true,
      ),
      // Usa il widget Consumer<NoteDB> per passare il provider al widget SingleDayCalendar2
      home:  Consumer<NoteDataBase>(
        builder: (context, noteDB, child) {
          return Calendar();
        },
      ),
    );
    }
  }

