import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/field_detail.dart';
import 'package:flutter_application_1/friends_page.dart';

class FieldsSearchPage extends StatefulWidget {
  const FieldsSearchPage({super.key});

  @override
  State<FieldsSearchPage> createState() => _FieldsSearchPageState();
}

class _FieldsSearchPageState extends State<FieldsSearchPage> {
  final List<Map<String, String>> _fields = [
    {'name': 'Campo A', 'city': 'Milano'},
    {'name': 'Campo B', 'city': 'Torino'},
  ];
  String query = '';

  @override
  Widget build(BuildContext context) {
    final results = _fields
        .where((f) => f['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Cerca campi')),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: CupertinoSearchTextField(
                onChanged: (v) => setState(() => query = v),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text("Vai al Profilo"),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => FriendsPage()),
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (_, i) {
                  final item = results[i];
                  return CupertinoListTile(
                    title: Text(item['name']!),
                    subtitle: Text(item['city']!),
                    onTap: () {
                      // apri dettaglio campo / prenotazione
                      Navigator.pushNamed(
                        context,
                        '/field_detail',
                        arguments: item,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// nota: CupertinoListTile è concettuale; se non disponibile usa ListTile o costruiscilo con Row/Container.
