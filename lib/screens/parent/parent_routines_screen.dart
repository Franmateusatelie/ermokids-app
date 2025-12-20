import '../../core/star_manager.dart';

appBar: AppBar(
  title: const Text('👨‍👩‍👧 Rotinas dos Pais'),
  actions: [
    FutureBuilder<int>(
      future: StarManager.getStars(),
      builder: (context, snapshot) {
        final stars = snapshot.data ?? 0;
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Center(
            child: Text(
              '⭐ $stars',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    )
  ],
),

