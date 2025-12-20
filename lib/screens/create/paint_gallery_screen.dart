import 'package:flutter/material.dart';
import '../../core/remote_drawings_service.dart';
import 'paint_screen.dart';

class PaintGalleryScreen extends StatefulWidget {
  const PaintGalleryScreen({super.key});

  @override
  State<PaintGalleryScreen> createState() => _PaintGalleryScreenState();
}

class _PaintGalleryScreenState extends State<PaintGalleryScreen> {
  List<String> drawings = [];
  bool loading = true;

  final List<String> localFallback = const [
    'assets/coloring/cat.png',
    'assets/coloring/dog.png',
    'assets/coloring/car.png',
    'assets/coloring/house.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadDrawings();
  }

  Future<void> _loadDrawings() async {
    final remote = await RemoteDrawingsService.fetchDrawings();
    setState(() {
      drawings = remote.isNotEmpty ? remote : localFallback;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Escolha um desenho 🖼️')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: drawings.length,
        itemBuilder: (context, index) {
          final src = drawings[index];
          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaintScreen(drawingAsset: src),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: src.startsWith('http')
                    ? Image.network(src, fit: BoxFit.contain)
                    : Image.asset(src, fit: BoxFit.contain),
              ),
            ),
          );
        },
      ),
    );
  }
}

