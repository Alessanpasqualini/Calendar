import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';


DateTime selectedDate = DateTime.now();

final List<StreamController<int>> _streamControllers =
      List.generate(42, (_) => StreamController<int>());
int count =0;

final StreamController<bool> _CalendarPageStreamController = StreamController<bool>();

class Calendar extends StatefulWidget{

  const Calendar({ super.key });
  @override
  State createState() => _CalendarPage();


}

class _CalendarPage extends State<StatefulWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<bool>(stream: _CalendarPageStreamController.stream,
          builder: (context, snapshot)
          {
             return CalendarBody();
          }
          ),
        ],
      )
    );
  }
}
  void _updateWidget(int index,int value) {
    _streamControllers.elementAt(index).sink.add(value);
  }

// Estendere PreferredSizeWidget per indicare la dimensione preferita dell'appBar
// ignore: must_be_immutable
class _AppBar extends StatelessWidget implements PreferredSizeWidget {

  String monthName = DateFormat.MMMM('it').format(selectedDate);
  String yearName= DateFormat.y().format(selectedDate);

  String day = "${DateFormat.EEEE('It').format(selectedDate)} ${selectedDate.day}";
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Personalizzare l'aspetto della barra delle applicazioni qui
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Selection(selector :MonthPicker(),dateFormatLabel:DateFormat.MONTH,pickerLabel:"Mese"),
          Selection(selector: _yPicker(context),pickerLabel: "Anno",dateFormatLabel: DateFormat.YEAR ,)
        ]
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
    String monthName = DateFormat(dateFormatLabel,'it').format(selectedDate);
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
        selectedDate: selectedDate,
        onChanged: (DateTime dateTime)
          {
            selectedDate = DateTime(dateTime.year,selectedDate.month,selectedDate.day);
            
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
  List<String> months = [
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
  // Mese selezionato
  String selectedMonth = 'Gennaio';

  MonthPicker({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child:Column(
          children: [
            const Divider(
              color: Color.fromARGB(195, 38, 4, 190), // Colore della linea
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
                          color: Color.fromARGB(255, 0, 0, 0),
                          ),
                      ),
                    );
                }).toList(),
                onSelectedItemChanged: (int index) {
                    selectedDate = DateTime(selectedDate.year,index+1,selectedDate.day);
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

  CalendarBody({super.key});
  
  @override
  State<StatefulWidget> createState()=>_calendarBody();
}

class _calendarBody extends State<CalendarBody>
{


  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize:MainAxisSize.max,
      children: _generateCalendarBody()
    );
  }

} 


class CalendarDay extends StatefulWidget
{

  @override
  State<StatefulWidget> createState()=> _CalendarDayState( controllerIndex: controllerIndex , bgColor: bgColor);
  int controllerIndex;
  final Color? bgColor;
  CalendarDay({
    super.key,
    required this.controllerIndex,
    this.bgColor =Colors.red
  });
  
  getDay() {}
}
class _CalendarDayState extends State<CalendarDay>  
{
    int controllerIndex;
    Color? bgColor = Colors.red;
    _CalendarDayState(
      {
        required this.controllerIndex,
        this.bgColor
      }
    );
  int getDay() => _day;
  int _day =0;
  @override
  void initState() {
    super.initState();
    _streamControllers.elementAt(controllerIndex).stream.listen((day) {
      setState(() {
        _day = day;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
      return Container(
      width: MediaQuery.of(context).size.width /7, // larghezza del 33% dello schermo
      height: MediaQuery.of(context).size.height /10, // larghezza del 33% dello schermo
      margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Text(_day>0? _day.toString(): "")
    );
    }
  }

List<Widget> _generateCalendarBody()
{
  List<Widget> bodyCalendar = <Widget>[]; // Questo è giusto
  int index = 0;
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
  int dayone = DateTime(selectedDate.year,selectedDate.month).weekday -2;

  int maxday = DateTime(selectedDate.year,selectedDate.month+1,0).day;
  for(var x = 0;x<7;x++)
  {
      bodyCalendar.add(Column(
          children:[
            Text(dayOfWeek.elementAt(x)),
            CalendarDay(controllerIndex: index,),
            CalendarDay(controllerIndex: index+1,),
            CalendarDay(controllerIndex: index+2,),
            CalendarDay(controllerIndex: index+3,),
            CalendarDay(controllerIndex: index+4,),
            CalendarDay(controllerIndex: index+5),
          ]
        ),);
        _updateWidget(index,(((7*0)+x-dayone)<=0 || ((7*0)+x-dayone)>maxday)?0:((7*0)+x-dayone));
        _updateWidget(index+1,(((7*1)+x-dayone)<=0 || ((7*1)+x-dayone)>maxday)?0:((7*1)+x-dayone));
        _updateWidget(index+2,(((7*2)+x-dayone)<=0 || ((7*2)+x-dayone)>maxday)?0:((7*2)+x-dayone));
        _updateWidget(index+3,(((7*3)+x-dayone)<=0 || ((7*3)+x-dayone)>maxday)?0:((7*3)+x-dayone));
        _updateWidget(index+4,(((7*4)+x-dayone)<=0 || ((7*4)+x-dayone)>maxday)?((7*4)+x-dayone-maxday):((7*4)+x-dayone));
        _updateWidget(index+5,(((7*5)+x-dayone)<=0 || ((7*5)+x-dayone)>maxday)?((7*5)+x-dayone-maxday):((7*5)+x-dayone));
        index = index+6;
    }  
  return bodyCalendar;
}
