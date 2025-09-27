import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  // Dati di esempio
  final List<String> _friends = ['Mario Rossi', 'Luca Verdi', 'Paolo Bianchi'];
  final List<String> _requests = ['Giovanni Gialli'];

  void _acceptRequest(String name) {
    setState(() {
      _requests.remove(name);
      _friends.add(name);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name è ora tuo amico!')),
    );
  }

  void _rejectRequest(String name) {
    setState(() {
      _requests.remove(name);
    });
  }

  void _removeFriend(String name) {
    setState(() {
      _friends.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amici'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sezione Richieste di Amicizia
            if (_requests.isNotEmpty) ...[
              Text(
                'Richieste in attesa',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _requests.length,
                itemBuilder: (context, index) {
                  final request = _requests[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person_add_alt_1),
                      title: Text(request),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () => _acceptRequest(request),
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () => _rejectRequest(request),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],

            // Sezione Lista Amici
            Text(
              'La tua lista amici',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _friends.isNotEmpty
                  ? ListView.builder(
                      itemCount: _friends.length,
                      itemBuilder: (context, index) {
                        final friend = _friends[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.person, color: Color(0xFF289775)),
                            title: Text(friend),
                            trailing: IconButton(
                              icon: const Icon(Icons.person_remove, color: Colors.grey),
                              onPressed: () => _removeFriend(friend),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Non hai ancora nessun amico.'),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logica per aggiungere un amico (es. mostrare un dialog)
        },
        backgroundColor: const Color(0xFF289775),
        child: const Icon(Icons.add),
        tooltip: 'Aggiungi amico',
      ),
    );
  }
}