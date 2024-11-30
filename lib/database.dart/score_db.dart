class HighScoreManager {
  // Singleton instance
  static final HighScoreManager _instance = HighScoreManager._internal();
  factory HighScoreManager() => _instance;

  // Private constructor
  HighScoreManager._internal();

  // List to store all scores
  final List<int> _scores = [];

  // Method to save a score
  void saveScore(int score) {
    _scores.add(score);
  }

  // Method to retrieve the highest score
  int getHighScore() {
    if (_scores.isEmpty) return 0; // Default score if no scores are stored
    return _scores.reduce((a, b) => a > b ? a : b);
  }
}
