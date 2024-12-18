import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../components/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await _speechToText.initialize();
    _startListening(); // Start listening automatically
  }

  void _startListening() async {
    if (!_isListening) {
      await _speechToText.listen(onResult: _onSpeechResult);
      print('Listening...');
      setState(() {
        _isListening = true;
      });
    }
  }

  void _stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    final recognizedWords = result.recognizedWords.toLowerCase();
    print('Recognized words: $recognizedWords');
    if (recognizedWords.contains('camera')) {
      Navigator.pushNamed(context, '/roam_mode');
    } else if (recognizedWords.contains('navigate to')) {
      final placeName = recognizedWords.split('navigate to ').last;
      // You need to implement a method to get coordinates from the place name
      final coordinates = _getCoordinatesFromPlaceName(placeName);
      Navigator.pushNamed(context, '/navigation_mode', arguments: coordinates);
    } else if (recognizedWords.contains('navigation')) {
      Navigator.pushNamed(context, '/navigation_mode');
    }

    // Stop listening and wait for 2 seconds before restarting
    _stopListening();
    await Future.delayed(const Duration(seconds: 2));
    _startListening();
  }

  Map<String, double> _getCoordinatesFromPlaceName(String placeName) {
    // Replace this with actual implementation
    return {'latitude': 37.7749, 'longitude': -122.4194};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Pathfinder'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isListening ? _stopListening : _startListening,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF004D40),
              ),
              child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/roam_mode');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF004D40),
                  ),
                  child: const Text('Roam Mode'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/navigation_mode');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF004D40),
                  ),
                  child: const Text('Navigation Mode'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
