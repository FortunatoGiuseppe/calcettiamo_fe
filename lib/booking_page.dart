import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/field_search.dart';

class BookingPage extends StatefulWidget {
  final Map<String, String>? field;
  const BookingPage({super.key, this.field});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Prenotazione')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(widget.field?['name'] ?? 'Seleziona campo'),
              const SizedBox(height: 12),
              CupertinoButton(
                onPressed: () async {
                  final date = await showCupertinoModalPopup<DateTime>(
                    context: context,
                    builder: (_) => SizedBox(
                      height: 250,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (d) {},
                      ),
                    ),
                  );
                  // per semplicità non usiamo il valore di ritorno qui.
                },
                child: const Text('Seleziona data'),
              ),
              const SizedBox(height: 12),
              CupertinoButton.filled(
                onPressed: () {
                  // invia richiesta di prenotazione al BE
                },
                child: const Text('Conferma prenotazione'),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text("Vai al Profilo"),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => FieldSearchPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
