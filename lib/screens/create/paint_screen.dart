import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PaintScreen extends StatefulWidget {
  final String drawingAsset;

  const PaintScreen({super.key, required this.drawingAsset});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  final List<Offset?> _points = [];
  Color _selectedColor = Colors.red;
  double _strokeWidth = 8.0;

  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.black,
    Colors.brown,
  ];

  void _clear() {
    setState(() {
      _points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pintar 🎨'),
        actions: [
          IconButton(
            tooltip: 'Limpar',
            icon: const Icon(Icons.delete),
            onPressed: _clear,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                RenderBox box = context.findRenderObject() as RenderBox;
                setState(() {
                  _points.add(box.globalToLocal(details.globalPosition));
                });
              },
              onPanEnd: (_) {
                _points.add(null);
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      widget.drawingAsset,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _PaintPainter(
                        points: _points,
                        color: _selectedColor,
                        strokeWidth: _strokeWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _colors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedColor == color
                                ? Colors.black
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Slider(
                  value: _strokeWidth,
                  min: 4,
                  max: 20,
                  divisions: 4,
                  label: 'Lápis',
                  onChanged: (v) {
                    setState(() => _strokeWidth = v);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaintPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;

  _PaintPainter({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




