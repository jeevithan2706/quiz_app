import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quiz_controller.dart';

// ignore: use_key_in_widget_constructors
class QuizScreen extends StatelessWidget {
  final QuizController controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 204, 198, 221),
        actions: [
          IconButton(
            icon: const Icon(
                Icons.exit_to_app), // You can use any icon you prefer
            onPressed: () {
              // Call the function to quit the quiz
              _quitQuiz(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          if (controller.currentQuestionIndex.value <
              controller.questions.length) {
            final question =
                controller.questions[controller.currentQuestionIndex.value];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${controller.currentQuestionIndex.value + 1} of ${controller.questions.length}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          minHeight: 10,
                          value: (controller.currentQuestionIndex.value + 1) /
                              controller.questions.length,
                          backgroundColor: Colors.grey[300],
                          color: const Color.fromARGB(255, 77, 255, 205),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  // Timer and Score
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Timer
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.timer, color: Colors.redAccent),
                            const SizedBox(width: 5),
                            Text(
                              '${controller.timeLeft.value}s',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      // Score
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orangeAccent),
                            const SizedBox(width: 5),
                            Text(
                              'Score: ${controller.score.value}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Question Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      question.question,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Options
                  Expanded(
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, index) {
                        final option = question.options[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () => controller.selectAnswer(option),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.deepPurpleAccent, width: 2),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              option,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          // If quiz is over or no questions left
          return const Center(
            child: Text(
              'Quiz Complete!',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        }),
      ),
    );
  }

  void _quitQuiz(BuildContext context) {
    // Show a confirmation dialog before quitting the quiz
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quit Quiz'),
        content: const Text('Are you sure you want to quit the quiz?'),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.pop(context);
              // Navigate back to home screen or desired screen
              Get.offAllNamed(
                  '/'); // Replace with your desired route, e.g., Home screen
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog without quitting
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
