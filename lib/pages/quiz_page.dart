import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import 'result_page.dart';
import '../widgets/theme_toggle.dart';
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
    final c = AppColors.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final options = currentQuestion['options'] as List<String>;
    final selectedAnswer = selectedAnswers[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
      actions: const [
        ThemeToggle(),
      ],
    ),
      backgroundColor: c.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              Text(
                'Semangat, ${widget.userName}! 👋',
                style: TextStyle(
                  fontSize: 15,
                  color: c.textSecondary,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Uji kemampuanmu',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progres Kuis',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                    ),
                  ),
                  Text(
                    '${currentQuestionIndex + 1} dari ${questions.length}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: c.textSecondary,
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
                  backgroundColor: c.track,
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
                  color: c.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: c.border,
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
                        color: c.warnBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'PERTANYAAN ${(currentQuestionIndex + 1).toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: c.warnText,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Text(
                      currentQuestion['question'] as String,
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
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
                              ? c.border
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
    final c = AppColors.of(context);
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
              ? c.selectedBg
              : c.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF16A6A1)
                : c.border,
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
                    : c.chip,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? Colors.white
                      : c.letterText,
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
                  color: c.textPrimary,
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