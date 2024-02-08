import 'package:flutter/material.dart';
import 'package:flutter_application_2/Calendar.dart';
import 'package:flutter_application_2/NoteDb.dart';
import 'package:flutter_application_2/Prova.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDB.initialize();
  runApp(
    ChangeNotifierProvider(
      create : (context) => NoteDB(),
      child:const MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => NoteDB(),
    child:
    
    MaterialApp(
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
       //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Calendar(),
    ),
    );
  }
}


