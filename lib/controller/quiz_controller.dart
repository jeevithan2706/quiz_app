
import 'package:get/get.dart';
import 'package:quiz/models/quiz_model.dart';
import 'dart:async';

class QuizController extends GetxController {
  final questions = <Question>[].obs;
  RxInt currentQuestionIndex = 0.obs;
  RxInt score = 0.obs;
  RxInt timeLeft = 15.obs;
  Timer? _timer;
  int consecutiveTimeouts = 0;

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
    startTimer();
  }

  // Load all questions
  void loadQuestions() {
    questions.assignAll([
      Question(
        question: "1. What is the capital of France?",
        options: ["Berlin", "Madrid", "Paris", "Rome"],
        answer: "Paris",
      ),
      Question(
        question: "2. Which element has the chemical symbol 'O'?",
        options: ["Oxygen", "Gold", "Silver", "Iron"],
        answer: "Oxygen",
      ),
      Question(
        question: "3. What is 5 + 3?",
        options: ["5", "8", "7", "9"],
        answer: "8",
      ),
      Question(
        question: "4. Which animal is known as the 'King of the Jungle'?",
        options: ["Tiger", "Elephant", "Lion", "Giraffe"],
        answer: "Lion",
      ),
      Question(
        question: "5. Which planet is closest to the Sun?",
        options: ["Earth", "Venus", "Mercury", "Mars"],
        answer: "Mercury",
      ),
      Question(
        question: "6. What color is the sky on a clear day?",
        options: ["Blue", "Green", "Red", "Yellow"],
        answer: "Blue",
      ),
    ]);
  }

  void startTimer() {
    _timer?.cancel();
    timeLeft.value = 15; // Reset the timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        handleTimeout();
      }
    });
  }

  void handleTimeout() {
    consecutiveTimeouts++;

    if (consecutiveTimeouts >= 6) {
      endQuiz();
    } else {
      nextQuestion();
    }
  }

  void selectAnswer(String selectedOption) {
    // Check if the selected answer is correct
    if (questions[currentQuestionIndex.value].answer == selectedOption) {
      score.value++;
    }
    consecutiveTimeouts = 0; // Reset timeout counter after answering
    nextQuestion();
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      startTimer(); // Restart timer for the next question
    } else {
      endQuiz();
    }
  }

  // To end the quiz and navigate to results
  void endQuiz() {
    _timer?.cancel();
    Get.offNamed('/results', arguments: {'score': score.value});
  }

  // To reset the quiz and navigate to home page
  void resetQuiz() {
    score.value = 0;
    currentQuestionIndex.value = 0;
    timeLeft.value = 15;
    consecutiveTimeouts = 0;
    Get.offAllNamed('/quiz');
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
