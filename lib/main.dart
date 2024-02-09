import 'package:flutter/material.dart';
import 'package:flutter_application_2/Calendar.dart';
import 'package:flutter_application_2/Note.dart';
import 'package:flutter_application_2/NoteDb.dart';
import 'package:flutter_application_2/Prova.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDB.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDB(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home:  SingleDayCalendar2(),
    );
    }
  }


