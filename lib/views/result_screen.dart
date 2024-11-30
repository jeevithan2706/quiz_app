import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import '../controller/quiz_controller.dart';
import '../database.dart/score_db.dart';

class ResultsScreen extends StatelessWidget {
  final QuizController controller = Get.find();
  final HighScoreManager scoreManager = HighScoreManager();
  final ConfettiController confettiController = ConfettiController();

  ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentScore = controller.score.value;
    int highScore = HighScoreManager().getHighScore();
    final isNewHighScore = currentScore > highScore;
    double accuracy =
        (controller.score.value / controller.questions.length) * 100;
    String performanceMessage = accuracy == 100
        ? "Perfect Score!"
        : accuracy >= 75
            ? "Great Job!"
            : accuracy >= 50
                ? "Good Effort!"
                : "Better Luck Next Time";

    // Save the current score
    scoreManager.saveScore(currentScore);

    // Start confetti if it's a new high score
    if (isNewHighScore) {
      confettiController.play();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Results',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purpleAccent, Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Confetti Widget
              if (isNewHighScore)
                ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ],
                ),
              if (isNewHighScore)
                const Text(
                  'New High Score!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              Text(
                'Your Score: ${controller.score.value} / ${controller.questions.length}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Accuracy: ${accuracy.toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                performanceMessage,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 182, 218, 212)),
              ),

              const SizedBox(height: 30),
              // Replay button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
                onPressed: () => controller.resetQuiz(),
                child: const Text(
                  'Replay',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              // Back to Home button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrangeAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
                onPressed: () => Get.offAllNamed('/'),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
