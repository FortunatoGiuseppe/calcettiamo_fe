import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/tournament_page.dart';

class HomeStatsPage extends StatelessWidget {
  const HomeStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // dati mock
    final points = 120;
    final bookings = 15;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Statistiche')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Punti: $points', style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 12),
              Text('Prenotazioni totali: $bookings'),
              const SizedBox(height: 24),
              CupertinoButton.filled(
                onPressed: () {
                  /* richiedi premio */
                },
                child: const Text('Richiedi premio'),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text("Vai al Profilo"),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => TournamentsPage()),
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
