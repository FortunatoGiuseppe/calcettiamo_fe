import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_start.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final List<String> friends = ['Mario', 'Luca'];
  final List<String> requests = ['Pippo'];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Amici')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (requests.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Richieste',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    for (var r in requests)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(r),
                          Row(
                            children: [
                              CupertinoButton(
                                child: const Text('Accetta'),
                                onPressed: () {
                                  /* accetta request */
                                },
                              ),
                              CupertinoButton(
                                child: const Text('Rifiuta'),
                                onPressed: () {
                                  /* rifiuta */
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              const SizedBox(height: 12),
              const Text(
                'Amici',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(friends[i]),
                    trailing: CupertinoButton(
                      child: const Text('Elimina'),
                      onPressed: () {
                        /* elimina */
                      },
                    ),
                  ),
                ),
              ),
              CupertinoButton.filled(
                onPressed: () {
                  /* invia richiesta */
                },
                child: const Text('Invita amico'),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text("Vai al Profilo"),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => HomeStatsPage()),
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
