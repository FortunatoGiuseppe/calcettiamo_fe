import 'package:flutter/material.dart';
import 'field_detail.dart';

// Rinominata per coerenza
class FieldSearchPage extends StatefulWidget {
  const FieldSearchPage({super.key});

  @override
  State<FieldSearchPage> createState() => _FieldSearchPageState();
}

class _FieldSearchPageState extends State<FieldSearchPage> {
  // Dati di esempio per i campi
  final List<Map<String, dynamic>> _allFields = [
    {'id': '1', 'name': 'Pro Vercelli', 'city': 'Milano', 'availability': 'Disponibile', 'price': 60.0},
    {'id': '2', 'name': 'Real Madrid', 'city': 'Roma', 'availability': 'Occupato', 'price': 75.0},
    {'id': '3', 'name': 'Team Sport', 'city': 'Napoli', 'availability': 'Disponibile', 'price': 55.0},
    {'id': '4', 'name': 'Green Park', 'city': 'Milano', 'availability': 'Disponibile', 'price': 65.0},
  ];

  List<Map<String, dynamic>> _foundFields = [];
  String _query = '';

  @override
  void initState() {
    _foundFields = _allFields;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allFields;
    } else {
      results = _allFields
          .where((field) =>
              field['name'].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              field['city'].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _query = enteredKeyword;
      _foundFields = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cerca Campi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: 'Cerca per nome o città',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _foundFields.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundFields.length,
                      itemBuilder: (context, index) {
                        final field = _foundFields[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.sports_soccer, color: Color(0xFF289775)),
                            title: Text(field['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(field['city']),
                            trailing: Text('${field['price']} €/ora', style: TextStyle(color: Colors.green[700])),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FieldDetailPage(field: field),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  : const Text(
                      'Nessun campo trovato',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}