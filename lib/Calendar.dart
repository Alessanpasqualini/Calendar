import 'package:flutter/material.dart';
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
  String yearName= DateFormat.y().format(selectedDate);

  String day = "${DateFormat.EEEE('It').format(selectedDate)} ${selectedDate.day}";
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Personalizzare l'aspetto della barra delle applicazioni qui
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Selection(selector :MonthPicker(),displayLabel:monthName ,pickerLabel:"Mese"),
          _Selection(selector: _yPicker(context),pickerLabel: "Anno",displayLabel: yearName,),
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
  String? pickerLabel;
  String displayLabel;
  _Selection(
    {
      required this.selector,
      required this.displayLabel,
      this.pickerLabel,
    }
  );

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
    onTap: () async{
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
      title: Text(pickerLabel??""),
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
  child:Text(displayLabel),
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
        final date = await showMonthYearPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
    );
    print(date);
}

class MonthPicker extends StatefulWidget {
  @override
  _MonthPickerState createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
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
                  setState(() {
                    print(index);
                  });
                },
            ),
            )
          ]
        )
      ),
    );
  }
}