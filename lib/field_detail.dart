import 'package:flutter/cupertino.dart';

class FieldDetailPage extends StatelessWidget {
  final Map<String, String> field;
  const FieldDetailPage({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(field['name'] ?? 'Campo'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field['name']!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Località: ${field['city']}'),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                onPressed: () {
                  // apri flow di prenotazione (seleziona data/ora)
                  Navigator.pushNamed(context, '/booking', arguments: field);
                },
                child: const Text('Prenota campo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
