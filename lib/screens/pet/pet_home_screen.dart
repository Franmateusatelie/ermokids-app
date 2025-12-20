import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetHomeScreen extends StatefulWidget {
  const PetHomeScreen({super.key});

  @override
  State<PetHomeScreen> createState() => _PetHomeScreenState();
}

class _PetHomeScreenState extends State<PetHomeScreen> {
  String pet = 'dog';
  int day = 1;
  String mood = 'feliz';

  final Map<String, bool> tasks = {
    'cafe': false,
    'banho': false,
    'almoco': false,
    'brincar': false,
    'jantar': false,
    'dormir': false,
  };

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      pet = p.getString('pet_type') ?? 'dog';
      day = p.getInt('pet_day') ?? 1;
      mood = p.getString('pet_mood') ?? 'feliz';
    });
  }

  Future<void> _doTask(String key) async {
    tasks[key] = true;

    if (tasks.values.contains(false)) {
      mood = '😐';
    } else {
      mood = '😄';
    }

    final p = await SharedPreferences.getInstance();
    await p.setString('pet_mood', mood);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(title: const Text('Meu Amiguinho')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            pet == 'dog' ? '🐶 Cachorrinho' : '🐱 Gatinho',
            style: const TextStyle(fontSize: 30),
          ),
          Text('Dia $day de 90'),
          const SizedBox(height: 10),
          Text('Humor: $mood', style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 20),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _btn('🍞 Café', 'cafe'),
              _btn('🛁 Banho', 'banho'),
              _btn('🍽️ Almoço', 'almoco'),
              _btn('🎾 Brincar', 'brincar'),
              _btn('🍲 Jantar', 'jantar'),
              _btn('🛏️ Dormir', 'dormir'),
            ],
          )
        ],
      ),
    );
  }

  Widget _btn(String label, String key) {
    return ElevatedButton(
      onPressed: tasks[key]! ? null : () => _doTask(key),
      child: Text(label),
    );
  }
}

