import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaintScreen extends StatefulWidget {
  const PaintScreen({super.key});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  Color selectedColor = Colors.red;

  final colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pintar Desenhos 🎨'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                'assets/coloring/animals/cat.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Paleta de cores
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: colors.map((c) {
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedColor = c);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedColor == c ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
