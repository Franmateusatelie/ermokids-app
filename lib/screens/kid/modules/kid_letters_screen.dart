import 'dart:math';
import 'package:flutter/material.dart';

class KidLettersScreen extends StatefulWidget {
  const KidLettersScreen({super.key});

  @override
  State<KidLettersScreen> createState() => _KidLettersScreenState();
}

class _KidLettersScreenState extends State<KidLettersScreen> {
  final Random random = Random();
  final TextEditingController controller = TextEditingController();

  int score = 0;

  late String emoji;
  late String word;
  late String maskedWord;
  late String missingLetter;

  final List<Map<String, String>> words = [
    {'emoji': '🐶', 'word': 'CACHORRO'},
    {'emoji': '🐱', 'word': 'GATO'},
    {'emoji': '🍎', 'word': 'MACA'},
    {'emoji': '🚗', 'word': 'CARRO'},
    {'emoji': '⭐', 'word': 'ESTRELA'},
    {'emoji': '🦁', 'word': 'LEAO'},
  ];

  @override
  void initState() {
    super.initState();
    _newWord();
  }

  void _newWord() {
    controller.clear();
    final item = words[random.nextInt(words.length)];
    word = item['word']!;
    emoji = item['emoji']!;

    final index = random.nextInt(word.length);
    missingLetter = word[index];

    maskedWord = word.replaceRange(index, index + 1, '_');
    setState(() {});
  }

  void _check() {
    final answer = controller.text.trim().toUpperCase();
    if (answer == missingLetter) {
      score++;
      _showFeedback(true);
    } else {
      _showFeedback(false);
    }
  }

  void _showFeedback(bool correct) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(correct ? '🎉 Muito bem!' : '😕 Ops!'),
        content: Text(
          correct
              ? 'Você completou a palavra!'
              : 'A letra correta era: $missingLetter',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _newWord();
            },
            child: const Text('Continuar'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        title: const Text('🔤 Completar Palavras'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 80),
                ),

                const SizedBox(height: 16),

                Text(
                  maskedWord,
                  style: const TextStyle(
                    fontSize: 32,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Digite a letra',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: _check,
                  child: const Text('Verificar'),
                ),

                const SizedBox(height: 20),

                Text(
                  'Pontuação: $score',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
