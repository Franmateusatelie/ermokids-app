import 'dart:math';
import 'package:flutter/material.dart';

class KidPortugueseScreen extends StatefulWidget {
  const KidPortugueseScreen({super.key});

  @override
  State<KidPortugueseScreen> createState() => _KidPortugueseScreenState();
}

class _KidPortugueseScreenState extends State<KidPortugueseScreen> {
  int level = 1;
  int score = 0;

  final Random random = Random();
  final TextEditingController controller = TextEditingController();

  late String question;
  late String correctAnswer;

  final List<Map<String, String>> level1 = [
    {'q': 'Qual é a letra?', 'a': 'A'},
    {'q': 'Qual é a letra?', 'a': 'B'},
    {'q': 'Qual é a letra?', 'a': 'C'},
  ];

  final List<Map<String, String>> level2 = [
    {'q': 'Complete: B _ L A', 'a': 'O'},
    {'q': 'Complete: C _ S A', 'a': 'A'},
    {'q': 'Complete: P _ T O', 'a': 'A'},
  ];

  final List<Map<String, String>> level3 = [
    {'q': 'Qual palavra é um animal?', 'a': 'GATO'},
    {'q': 'Qual palavra é um animal?', 'a': 'CACHORRO'},
    {'q': 'Qual palavra é um animal?', 'a': 'PATO'},
  ];

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    controller.clear();

    List<Map<String, String>> base;
    if (level <= 3) {
      base = level1;
    } else if (level <= 6) {
      base = level2;
    } else {
      base = level3;
    }

    final item = base[random.nextInt(base.length)];
    question = item['q']!;
    correctAnswer = item['a']!;
    setState(() {});
  }

  void _checkAnswer() {
    final answer = controller.text.trim().toUpperCase();

    if (answer == correctAnswer) {
      score++;
      if (score % 5 == 0) level++;
      _showFeedback(true);
    } else {
      _showFeedback(false);
    }
  }

  void _showFeedback(bool correct) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(correct ? '🎉 Muito bem!' : '😕 Tente novamente'),
        content: Text(
          correct
              ? 'Você acertou!\nNível: $level'
              : 'Resposta correta: $correctAnswer',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _generateQuestion();
            },
            child: const Text('Continuar'),
          ),
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
        title: const Text('📖 Português'),
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
                  'Nível $level',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Digite a resposta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _checkAnswer,
                  child: const Text('Responder'),
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

