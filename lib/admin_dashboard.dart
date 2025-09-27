import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/booking_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Dashboard Admin'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Amministrazione',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              CupertinoButton(
                onPressed: () {
                  // apri lista utenti -> modifica ruolo
                },
                child: const Text('Gestisci utenti / Ruoli'),
              ),
              const SizedBox(height: 8),
              CupertinoButton(
                onPressed: () {
                  // apri log, segnalazioni
                },
                child: const Text('Segnalazioni / Log'),
              ),
              const SizedBox(height: 8),
              CupertinoButton(
                onPressed: () {
                  // statistiche
                },
                child: const Text('Statistiche / Report'),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text("Vai al Profilo"),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => BookingPage()),
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
