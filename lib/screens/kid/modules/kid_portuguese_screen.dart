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

  final Random _random = Random();
  final TextEditingController _controller = TextEditingController();

  late String question;
  late String correctAnswer;
  Widget? visual;

  /// 🔤 MAIS DE 40 ITENS (LETRAS + SÍLABAS)
  final List<String> lettersLevel1 = [
    // Alfabeto (26)
    'A','B','C','D','E','F','G','H','I','J','K','L','M',
    'N','O','P','Q','R','S','T','U','V','W','X','Y','Z',

    // Sílabas simples (+20)
    'BA','BE','BI','BO','BU',
    'CA','CE','CI','CO','CU',
    'DA','DE','DI','DO','DU',
    'FA','FE','FI','FO','FU',
  ];

  @override
  void initState() {
    super.initState();
    _generate();
  }

  void _generate() {
    _controller.clear();

    // 🔹 NÍVEL 1 — reconhecer letras e sílabas
    if (level <= 3) {
      final item = lettersLevel1[_random.nextInt(lettersLevel1.length)];
      question = 'Qual é esta letra?';
      correctAnswer = item;
      visual = Text(
        item,
        style: const TextStyle(
          fontSize: 120,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    // 🔹 NÍVEL 2 — letra inicial da palavra
    else if (level <= 6) {
      final items = [
        {'emoji': '🐶', 'word': 'GATO'},
        {'emoji': '🍎', 'word': 'MAÇÃ'},
        {'emoji': '🚗', 'word': 'CARRO'},
        {'emoji': '🐸', 'word': 'SAPO'},
        {'emoji': '🐱', 'word': 'GATO'},
        {'emoji': '⚽', 'word': 'BOLA'},
      ];
      final item = items[_random.nextInt(items.length)];
      question = 'Qual letra começa a palavra?';
      correctAnswer = item['word']![0];
      visual = Column(
        children: [
          Text(item['emoji']!, style: const TextStyle(fontSize: 80)),
          const SizedBox(height: 10),
          Text(
            item['word']!,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    // 🔹 NÍVEL 3 — completar palavras
    else {
      final items = [
        {'missing': 'A', 'display': 'C _ S A'},
        {'missing': 'O', 'display': 'B _ L A'},
        {'missing': 'A', 'display': 'P _ T O'},
        {'missing': 'E', 'display': 'L _ I T E'},
        {'missing': 'A', 'display': 'F _ C A'},
      ];
      final item = items[_random.nextInt(items.length)];
      question = 'Complete a palavra';
      correctAnswer = item['missing']!;
      visual = Text(
        item['display']!,
        style: const TextStyle(
          fontSize: 36,
          letterSpacing: 4,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    setState(() {});
  }

  void _check() {
    final answer = _controller.text.trim().toUpperCase();
    final correct = answer == correctAnswer;

    if (correct) {
      score++;
      if (score % 5 == 0) level++;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(correct ? '🎉 Muito bem!' : '😕 Tente novamente'),
        content: Text(
          correct
              ? 'Você acertou!'
              : 'A resposta correta é: $correctAnswer',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _generate();
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
                const SizedBox(height: 16),

                Text(
                  question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),
                visual ?? const SizedBox(),
                const SizedBox(height: 20),

                TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Digite exatamente o que aparece',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: _check,
                  child: const Text('Responder'),
                ),

                const SizedBox(height: 12),
                Text('⭐ Pontos: $score'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


