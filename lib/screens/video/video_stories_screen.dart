import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class VideoStoriesScreen extends StatefulWidget {
  const VideoStoriesScreen({super.key});

  @override
  State<VideoStoriesScreen> createState() => _VideoStoriesScreenState();
}

class _VideoStoriesScreenState extends State<VideoStoriesScreen> {
  List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
    _carregarVideos();
  }

  Future<void> _carregarVideos() async {
    // 👉 JSON pode ficar hospedado no GitHub ou outro local público
    final url = Uri.parse(
        'https://raw.githubusercontent.com/SEU_USUARIO/ermokids-assets/main/videos.json');

    final res = await http.get(url);
    if (res.statusCode == 200) {
      setState(() {
        videos = json.decode(res.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Histórias em Vídeo 📺'),
        centerTitle: true,
      ),
      body: videos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final v = videos[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.play_circle_fill,
                        size: 40, color: Colors.deepPurple),
                    title: Text(
                      v['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text('História infantil'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              VideoPlayerScreen(url: v['url']),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  const VideoPlayerScreen({super.key, required this.url});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
