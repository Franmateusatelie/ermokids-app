import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KidDinoEggScreen extends StatefulWidget {
  const KidDinoEggScreen({super.key});

  @override
  State<KidDinoEggScreen> createState() => _KidDinoEggScreenState();
}

class _KidDinoEggScreenState extends State<KidDinoEggScreen> {
  int days = 0;
  bool fed = false;
  bool bathed = false;
  bool slept = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      days = p.getInt('dino_days') ?? 0;
      fed = p.getBool('dino_fed') ?? false;
      bathed = p.getBool('dino_bathed') ?? false;
      slept = p.getBool('dino_slept') ?? false;
    });
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('dino_days', days);
    await p.setBool('dino_fed', fed);
    await p.setBool('dino_bathed', bathed);
    await p.setBool('dino_slept', slept);
  }

  void _checkDayComplete() async {
    if (fed && bathed && slept) {
      setState(() {
        days++;
        fed = false;
        bathed = false;
        slept = false;
      });
      await _save();
      _showDayComplete();
    } else {
      _save();
    }
  }

  void _showDayComplete() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('🌟 Dia completo!'),
        content: Text(
          days >= 30
              ? '🎉 O dinossauro nasceu!'
              : 'Você cuidou muito bem hoje!\nDias: $days / 30',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  Widget _careButton({
    required String emoji,
    required String label,
    required bool done,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: done ? Colors.grey : Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: done ? null : onTap,
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final finished = days >= 30;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        title: const Text('🦖 Ovinho do Dino'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Text(
              finished ? '🦖' : '🥚',
              style: const TextStyle(fontSize: 120),
            ),

            const SizedBox(height: 10),

            Text(
              finished
                  ? 'Seu dinossauro nasceu!'
                  : 'Dias cuidados: $days / 30',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            if (!finished)
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _careButton(
                    emoji: '🥕',
                    label: 'Alimentar',
                    done: fed,
                    onTap: () {
                      setState(() => fed = true);
                      _checkDayComplete();
                    },
                  ),
                  _careButton(
                    emoji: '🛁',
                    label: 'Dar banho',
                    done: bathed,
                    onTap: () {
                      setState(() => bathed = true);
                      _checkDayComplete();
                    },
                  ),
                  _careButton(
                    emoji: '😴',
                    label: 'Dormir',
                    done: slept,
                    onTap: () {
                      setState(() => slept = true);
                      _checkDayComplete();
                    },
                  ),
                ],
              ),

            if (finished)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Parabéns! Continue cuidando do seu amigo 🦖',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

