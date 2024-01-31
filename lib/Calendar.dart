import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

DateTime selectedDate = DateTime.now();

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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
        ]
      )
    );
  }
}

// Estendere PreferredSizeWidget per indicare la dimensione preferita dell'appBar
class _AppBar extends StatelessWidget implements PreferredSizeWidget {

  String monthName = DateFormat.MMMM('it').format(selectedDate);

  String day = "${DateFormat.EEEE('It').format(selectedDate)} ${selectedDate.day}";
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Personalizzare l'aspetto della barra delle applicazioni qui
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              final selectedDate = showMonthYearPicker(
                locale: Locale('it','IT'),
                initialMonthYearPickerMode: MonthYearPickerMode.month,
                context: context,
                initialDate: DateTime.now(), // Today's date
                firstDate: DateTime(2000, 5), // Stating date : May 2000
                lastDate: DateTime(2050), // Ending date: Dec 2050
              );
            }, child: Text(monthName),
          ),
            _Selection(selector: _yPicker(context),),
            Text(
              day,
              textAlign: TextAlign.end,
            ),
        ]
      )
    );
  }

  // Implementare il metodo preferredSize per restituire la dimensione desiderata
  @override
  Size get preferredSize => Size.fromHeight(50.0);
}

class _Selection extends StatelessWidget  
{
  Widget selector;
  _Selection(
    {
      required this.selector,
    }
  );
  String year= DateFormat.y().format(selectedDate);
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
    onTap: () async{
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Year"),
      content:Container
      (
        width: 300,
        height: 300,
        child: selector
      )
    );
    }
    );
    },
  child:Text(year),
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
          // close the dialog when year is selected.
          Navigator.pop(context);           
          }     
        );
}

Future mSelection(BuildContext context)
async {
        showMonthYearPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
    );
}