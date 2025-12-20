import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final AudioPlayer _player = AudioPlayer();
  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  final List<Map<String, String>> _musics = [
    {'title': 'Música Alegre', 'file': 'music/musica1.mp3'},
    {'title': 'Canção Feliz', 'file': 'music/musica2.mp3'},
    {'title': 'Hora de Brincar', 'file': 'music/musica3.mp3'},
  ];

  @override
  void initState() {
    super.initState();

    _player.onDurationChanged.listen((d) {
      setState(() => _duration = d);
    });

    _player.onPositionChanged.listen((p) {
      setState(() => _position = p);
    });

    _player.onPlayerComplete.listen((event) {
      _next();
    });
  }

  Future<void> _play() async {
    await _player.play(AssetSource(_musics[_currentIndex]['file']!));
    setState(() => _isPlaying = true);
  }

  Future<void> _pause() async {
    await _player.pause();
    setState(() => _isPlaying = false);
  }

  void _next() {
    _currentIndex = (_currentIndex + 1) % _musics.length;
    _play();
  }

  void _previous() {
    _currentIndex =
        (_currentIndex - 1 + _musics.length) % _musics.length;
    _play();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final music = _musics[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎵 Músicas ErmoKids'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              music['title']!,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Slider(
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds
                  .clamp(0, _duration.inSeconds)
                  .toDouble(),
              onChanged: (value) async {
                await _player.seek(Duration(seconds: value.toInt()));
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  onPressed: _previous,
                  icon: const Icon(Icons.skip_previous),
                ),
                IconButton(
                  iconSize: 70,
                  onPressed: _isPlaying ? _pause : _play,
                  icon: Icon(
                    _isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
                  ),
                ),
                IconButton(
                  iconSize: 50,
                  onPressed: _next,
                  icon: const Icon(Icons.skip_next),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
