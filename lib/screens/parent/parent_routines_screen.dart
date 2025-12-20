import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentRoutinesScreen extends StatefulWidget {
  const ParentRoutinesScreen({super.key});

  @override
  State<ParentRoutinesScreen> createState() => _ParentRoutinesScreenState();
}

class _ParentRoutinesScreenState extends State<ParentRoutinesScreen> {
  List<Map<String, dynamic>> routines = [];

  @override
  void initState() {
    super.initState();
    loadRoutines();
  }

  Future<void> loadRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('routines') ?? [];
    setState(() {
      routines = data.map((e) => Map<String, dynamic>.from(
        Map.fromEntries(
          e.split('|').map((p) {
            final parts = p.split('=');
            return MapEntry(parts[0], parts[1]);
          }),
        ),
      )).toList();
    });
  }

  Future<void> removeRoutine(int index) async {
    final prefs = await SharedPreferences.getInstance();
    routines.removeAt(index);
    final saved = routines
        .map((e) => 'title=${e['title']}|time=${e['time']}')
        .toList();
    await prefs.setStringList('routines', saved);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rotinas dos Pais')),
      body: routines.isEmpty
          ? const Center(child: Text('Nenhuma rotina criada'))
          : ListView.builder(
              itemCount: routines.length,
              itemBuilder: (context, i) {
                final r = routines[i];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(r['title'] ?? ''),
                    subtitle: Text('Horário: ${r['time'] ?? ''}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeRoutine(i),
                    ),
                  ),
                );
              },
            ),
    );
  }
}







