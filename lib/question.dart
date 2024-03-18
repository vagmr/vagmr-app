class Question {
  String _questionText = "";
  bool _questionAnswer = false;

  Question({required String q, required bool a}) {
    _questionText = q;
    _questionAnswer = a;
  }
  bool isCorrect() {
    return _questionAnswer;
  }

  String getQuestion() {
    return _questionText;
  }
}
