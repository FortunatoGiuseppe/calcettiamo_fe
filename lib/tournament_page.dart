import 'package:flutter/cupertino.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  final List<String> tournaments = ['Torneo Estivo', 'Coppa Invernale'];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Tornei')),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tournaments.length,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.all(8),
                  child: CupertinoButton(
                    onPressed: () {
                      // dettaglio torneo o iscrizione
                    },
                    child: Text(tournaments[i]),
                  ),
                ),
              ),
            ),
            CupertinoButton.filled(
              onPressed: () {
                // apri form crea torneo (solo manager)
              },
              child: const Text('Crea torneo'),
            ),
          ],
        ),
      ),
    );
  }
}
