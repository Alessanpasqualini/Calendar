import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Note.dart';
import 'package:flutter_application_2/NoteDataBase.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';


DateTime currentDate = DateTime.now();
DateTime selectedDate = DateTime.now();

final StreamController<bool> _CalendarPageStreamController = StreamController<bool>();

final StreamController<bool> _CalendarPageStreamController2 = StreamController<bool>();


class Calendar extends StatefulWidget{

  const Calendar({ super.key });
  @override
  State createState() => _CalendarPage();


}

class _CalendarPage extends State<StatefulWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,66,66,66),
      appBar: _AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<bool>(stream: _CalendarPageStreamController.stream,
          builder: (context, snapshot)
          {
            _CalendarPageStreamController2.sink.add(true);
             return const CalendarBody();
          }
          ),
        ],
      )
    );
  }
}

// Estendere PreferredSizeWidget per indicare la dimensione preferita dell'appBar
// ignore: must_be_immutable
class _AppBar extends StatelessWidget implements PreferredSizeWidget {

  String yearName= DateFormat.y().format(currentDate);

  String day = "${DateFormat.EEEE('It').format(currentDate)} ${currentDate.day}";
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255,66,66,66),
      // Personalizzare l'aspetto della barra delle applicazioni qui
      title:
      Column(
        children: [
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Selection(selector :MonthPicker(),dateFormatLabel:DateFormat.MONTH,pickerLabel:"Mese"),
          Selection(selector: _yPicker(context),pickerLabel: "Anno",dateFormatLabel: DateFormat.YEAR ,)
        ]
      ),
                  const Divider(
              color: Color.fromARGB(255, 227 , 227, 227), // Colore della linea
              thickness: 1, // Spessore della linea
              indent: 5, // Margine della linea
            ),
        ],
      )
    );
  }

  // Implementare il metodo preferredSize per restituire la dimensione desiderata
  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

// ignore: must_be_immutable
class Selection extends StatefulWidget
{

  Widget selector;
  String? pickerLabel;
  String dateFormatLabel;
  Selection(
    {
      super.key, 
      required this.selector,
      required this.dateFormatLabel,
      this.pickerLabel,
    }
  );

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _SelectionState createState() =>_SelectionState(selector: selector, dateFormatLabel: dateFormatLabel,pickerLabel: pickerLabel);
}
class _SelectionState extends State<Selection>  
{
  Widget selector;
  String? pickerLabel;
  String dateFormatLabel;
  _SelectionState(
    {
      required this.selector,
      required this.dateFormatLabel,
      this.pickerLabel,
    }
  );

  @override
  Widget build(BuildContext context)
  {
    String monthName = DateFormat(dateFormatLabel,'it').format(currentDate);
    monthName = monthName.replaceFirst(monthName[0],monthName[0].toUpperCase());
    return GestureDetector(
    onTap: () async{
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
      title: Text(pickerLabel??""),
      content:SizedBox
      (
        width: 300,
        height: 300,
        child: selector
      )
    );
    }
    ).then((value) => {
      setState(
        () => _CalendarPageStreamController.sink.add(true))
      }
    );
    },
  child:Text(monthName),
  );
  }
      
}

Widget _yPicker(BuildContext context)
{
 
 return YearPicker(
        firstDate: DateTime(DateTime.now().year - 100, 1),
        lastDate: DateTime(DateTime.now().year + 100, 1),
        selectedDate: currentDate,
        onChanged: (DateTime dateTime)
          {
            currentDate = DateTime(dateTime.year,currentDate.month,currentDate.day);
            
          // close the dialog when year is selected.
          Navigator.pop(context);           
          }     
        );
}

Future mSelection(BuildContext context)
async {
        // ignore: unused_local_variable
        final date = await showMonthYearPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
    );
}

class MonthPicker extends StatelessWidget{
  // Lista dei mesi
  final List<String> months = [
    'Gennaio',
    'Febbraio',
    'Marzo',
    'Aprile',
    'Maggio',
    'Giugno',
    'Luglio',
    'Agosto',
    'Settembre',
    'Ottobre',
    'Novembre',
    'Dicembre'
  ];

  MonthPicker({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child:Column(
          children: [
            const Divider(
              color: Color.fromARGB(255, 227 , 227, 227), // Colore della linea
              thickness: 1, // Spessore della linea
              indent: 5, // Margine della linea
            ),
            Expanded(
              child:ListWheelScrollView(
                itemExtent: 50, // Altezza di ogni elemento
                diameterRatio: 1.5, // Rapporto tra il diametro della ruota e l'altezza dello schermo
                magnification: 1.5, // Fattore di ingrandimento dell'elemento centrale
                useMagnifier: true, // Usa l'effetto di ingrandimento
                physics: const FixedExtentScrollPhysics(), // Permette di scorrere solo un elemento alla volta
                children: months.map((String month) {
                  return Center(
                    child:
                        Text(
                        month,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 227 , 227, 227),
                          ),
                      ),
                    );
                }).toList(),
                onSelectedItemChanged: (int index) {
                    currentDate = DateTime(currentDate.year,index+1,currentDate.day);
                },
            ),
            )
          ]
        )
      ),
    );
  }
}

class CalendarBody extends StatefulWidget 
{

  const CalendarBody({super.key});
  
  @override
  State<StatefulWidget> createState()=>_calendarBody();
}

class _calendarBody extends State<CalendarBody>
{
  
   @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
  return StreamBuilder<bool>(stream: _CalendarPageStreamController2.stream,
   builder: 
   (context, snapshot)
          {
            return FutureBuilder(
            future: _generateCalendarBody(context),
            builder: (context,AsyncSnapshot<List<Widget>> snapshot)
            {
              if(snapshot.connectionState!=ConnectionState.done)
              {
                return Lottie.asset('assets/CalendarLoading.json', fit: BoxFit.fitWidth);
              }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize:MainAxisSize.max,
              children: snapshot.data!
            );
            });
          }
     );
  }
} 

Future<List<Widget>> _generateCalendarBody(BuildContext context) 
async {

  List<Widget> bodyCalendar = <Widget>[];
  Color standardBgColor =const Color.fromARGB(118, 227, 227, 227);
  Color weekendColor = const Color.fromARGB(37, 247, 0, 0); 
  Color todayColor = const Color.fromARGB(134, 234, 238, 6); 
  Color contColor = standardBgColor;

    final noteDB = context.watch<NoteDataBase>();


  DateTime today = DateTime.now();

  Set<String> dayOfWeek = <String>
  {
    "Lun",
    "Mar",
    "Mer",
    "Gio",
    "Ven",
    "Sab",
    "Dom"
  };
  int dayone = DateTime(currentDate.year,currentDate.month).weekday -2;

  int maxday = DateTime(currentDate.year,currentDate.month+1,0).day;
  


  for(var x = 0;x<7;x++)
  {
      List<Widget> calendarRow = <Widget>[]; // Questo è giusto
      calendarRow.add(
        Text(dayOfWeek.elementAt(x)),
      );

    for (var j = 0;j<6;j++)
    {
      List<Widget> cellText = <Widget>[];

      int giorno = 6*j+j-dayone+x;

      if (giorno == currentDate.day && currentDate.month == today.month && currentDate.year == today.year ) contColor = todayColor;
      else 
      {
        if (giorno > maxday) {contColor = Color.fromARGB(30, contColor.red, contColor.green, contColor.blue);}
           else if(x == 6) {contColor = weekendColor;}
      else {contColor = standardBgColor;}
      }

      giorno>maxday?giorno-=maxday:giorno;
      cellText.add(Text(giorno>0?giorno.toString():""));
      if (await noteDB.haveNote(DateTime(currentDate.year,currentDate.month,giorno)))
      {
      cellText.add(Lottie.asset(
        'assets/CalendarLoading.json',
        width: 50
        ));
      }
      calendarRow.add(
        GestureDetector(
          child: Container(
              width: MediaQuery.of(context).size.width /7,
              height: MediaQuery.of(context).size.height /6.9,
              margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                shape:BoxShape.rectangle,
                border: Border.all(
                  color:  const Color.fromARGB(255,17,17,17),
                  ),
                color: contColor
              ),
              child: Row(
                children:[Column (children: cellText)],
                )
            ),
            onTap:(){
              selectedDate = DateTime(selectedDate.year,selectedDate.month,giorno);
              Navigator.push(
                context,
              MaterialPageRoute(builder: (context) => const SingleDayCalendar())
              );
            }
        )
        );
    }
    bodyCalendar.add(Column(
        children:calendarRow
      ),);
    }  
  return bodyCalendar;
}

class SingleDayCalendar extends StatefulWidget{

  const SingleDayCalendar({ super.key });
  @override
  State createState() => _SingleDayCalendarPage();


}

class _SingleDayCalendarPage extends State<StatefulWidget>  {

  final textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final noteDB = context.watch<NoteDataBase>();

    List<Note> currentNotes = noteDB.currentNotes;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,66,66,66),
      appBar: AppBar(
        title: Text(DateFormat.MMMMEEEEd('It').format(selectedDate)), 
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                IconButton(
                  onPressed: () => updateNote(currentNotes[index]) , 
                  icon: const Icon(Icons.edit)
                  ),

                IconButton(
                  onPressed: () => deleteNotes(currentNotes[index]) , 
                  icon: const Icon(Icons.delete)
                  )
              ],
            ),
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

            context.read<NoteDataBase>().addNote(textController.text, selectedDate);

            textController.clear();
            Navigator.pop(context);

            },
            child: const Text("Crea"),
          )
        ],
      ),
    );
  }
  
  void readNotes()
  {
    context.read<NoteDataBase>().fetchNotes(selectedDate);
  }

  void updateNote(Note note)
  {
    textController.text = note.text;
    showDialog(
      context:context ,
       builder: (context)=> 
       AlertDialog(
        title: const Text("Modifica la nota"),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed:() {
              context.read<NoteDataBase>().updateNotes(note,textController.text);
              textController.clear();
              Navigator.pop(context);
              },
              child:const Text("Modifica")
            ),
        ],
      ),
    );
  }

  void deleteNotes(Note note)
  {
    context.read<NoteDataBase>().deleteNotes(note);
  }
}

