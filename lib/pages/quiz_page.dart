import 'package:flutter/material.dart';
import 'result_page.dart';
import 'package:uts_pm1/data/data_dummy.dart';


class QuizPage extends StatefulWidget {
  final String userName;

  const QuizPage({
    super.key,
    required this.userName,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> questions = dummyQuestions;

  int currentQuestionIndex = 0;

  final Map<int, int> selectedAnswers = {};

  bool get isFirstQuestion => currentQuestionIndex == 0;

  bool get isLastQuestion =>
      currentQuestionIndex == questions.length - 1;

  Map<String, dynamic> get currentQuestion =>
      questions[currentQuestionIndex];

  void _selectAnswer(int index) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = index;
    });
  }

  int _calculateCorrectAnswers() {
    int correctCount = 0;

    for (int i = 0; i < questions.length; i++) {
      final int? selectedAnswer = selectedAnswers[i];
      final int correctAnswer = questions[i]['correctAnswer'] as int;

      if (selectedAnswer == correctAnswer) {
        correctCount++;
      }
    }

    return correctCount;
  }

  void _goBack() {
    if (isFirstQuestion) return;

    setState(() {
      currentQuestionIndex--;
    });
  }

  void _goNext() {
    if (isLastQuestion) return;

    setState(() {
      currentQuestionIndex++;
    });
  }

  
  void _submitQuiz() {
    final int correctAnswers = _calculateCorrectAnswers();

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ResultPage(
          userName: widget.userName,
          correctAnswers: correctAnswers,
          totalQuestions: questions.length,
          questions: questions,
          selectedAnswers: selectedAnswers,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final options = currentQuestion['options'] as List<String>;
    final selectedAnswer = selectedAnswers[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Quiz Time',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202B3C),
                      ),
                    ),
                  ),
                  
                ],
              ),

              const SizedBox(height: 28),

              Text(
                'Semangat, ${widget.userName}! 👋',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF7B8798),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Uji kemampuanmu',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202B3C),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progres Kuis',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF202B3C),
                    ),
                  ),
                  Text(
                    '${currentQuestionIndex + 1} dari ${questions.length}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7B8798),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value:
                      (currentQuestionIndex + 1) / questions.length,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE5EAF0),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF16A6A1),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFE8EDF3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2D8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'PERTANYAAN ${(currentQuestionIndex + 1).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Color(0xFFB7791F),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Text(
                      currentQuestion['question'] as String,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202B3C),
                      ),
                    ),

                    const SizedBox(height: 28),

                    ...List.generate(options.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _AnswerOption(
                          letter: String.fromCharCode(65 + index),
                          answer: options[index],
                          isSelected: selectedAnswer == index,
                          onTap: () => _selectAnswer(index),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: isFirstQuestion ? null : _goBack,
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Back'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF16A6A1),
                        disabledForegroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          vertical: 17,
                        ),
                        side: BorderSide(
                          color: isFirstQuestion
                              ? const Color(0xFFE2E8F0)
                              : const Color(0xFF16A6A1),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isLastQuestion ? _submitQuiz : _goNext,
                      icon: Icon(
                        isLastQuestion
                            ? Icons.check_rounded
                            : Icons.arrow_forward_rounded,
                      ),
                      label: Text(
                        isLastQuestion ? 'Submit' : 'Next',
                      ),
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF16A6A1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 17,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Center(
                child: Text(
                  'Pilih jawaban terbaik menurutmu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7B8798),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  final String letter;
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.letter,
    required this.answer,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE8F8F6)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF16A6A1)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF16A6A1)
                    : const Color(0xFFF0F3F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF64748B),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: const Color(0xFF202B3C),
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF16A6A1),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}