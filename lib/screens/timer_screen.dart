import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _selectedMinutes = 5;
  int _remainingSeconds = 5 * 60;
  Timer? _timer;
  bool _isRunning = false;

  final player = AudioPlayer();

  void _startTimer() {
    if (_timer != null) _timer!.cancel();
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
        setState(() => _isRunning = false);
        _playSound();
        _showDoneDialog();
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = _selectedMinutes * 60;
      _isRunning = false;
    });
  }

  void _playSound() async {
    await player.play(AssetSource('sounds/bell.mp3'));
  }

  void _showDoneDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hoàn thành"),
        content: const Text("Thời gian thiền đã kết thúc."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetTimer();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meditation Timer"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_remainingSeconds),
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : _startTimer,
                  child: const Text("Start"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 40),
            DropdownButton<int>(
              value: _selectedMinutes,
              items: [5, 10, 15, 20, 25]
                  .map((min) => DropdownMenuItem(
                value: min,
                child: Text("$min phút"),
              ))
                  .toList(),
              onChanged: (value) {
                if (!_isRunning && value != null) {
                  setState(() {
                    _selectedMinutes = value;
                    _remainingSeconds = value * 60;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
