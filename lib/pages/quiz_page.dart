import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../data/data_dummy.dart';
import '../utils/responsive.dart';
import '../widgets/answer_option.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_body.dart';
import '../widgets/secondary_button.dart';
import '../widgets/theme_toggle.dart';
import 'result_page.dart';

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

  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

  Map<String, dynamic> get currentQuestion => questions[currentQuestionIndex];

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
    final options = currentQuestion['options'] as List<String>;
    final selectedAnswer = selectedAnswers[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        actions: const [
          ThemeToggle(),
        ],
      ),
      backgroundColor: c.background,
      body: ResponsiveBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.sz(20)),
            Text(
              'Semangat, ${widget.userName}! 👋',
              style: TextStyle(
                fontSize: context.sp(15),
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: context.sz(8)),
            Text(
              'Uji kemampuanmu',
              style: TextStyle(
                fontSize: context.sp(25),
                fontWeight: FontWeight.w700,
                color: c.textPrimary,
              ),
            ),
            SizedBox(height: context.sz(24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progres Kuis',
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
                Text(
                  '${currentQuestionIndex + 1} dari ${questions.length}',
                  style: TextStyle(
                    fontSize: context.sp(13),
                    fontWeight: FontWeight.w600,
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.sz(12)),
            ClipRRect(
              borderRadius: BorderRadius.circular(context.sz(20)),
              child: LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / questions.length,
                minHeight: context.sz(8),
                backgroundColor: c.track,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: context.sz(28)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.sz(24)),
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(context.sz(24)),
                border: Border.all(color: c.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: context.sz(20),
                    offset: Offset(0, context.sz(8)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.sz(12),
                      vertical: context.sz(7),
                    ),
                    decoration: BoxDecoration(
                      color: c.warnBg,
                      borderRadius: BorderRadius.circular(context.sz(10)),
                    ),
                    child: Text(
                      'PERTANYAAN ${(currentQuestionIndex + 1).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: c.warnText,
                        fontSize: context.sp(11),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  SizedBox(height: context.sz(22)),
                  Text(
                    currentQuestion['question'] as String,
                    style: TextStyle(
                      fontSize: context.sp(20),
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.sz(28)),
                  ...List.generate(options.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: context.sz(12)),
                      child: AnswerOption(
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
            SizedBox(height: context.sz(24)),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: 'Back',
                    icon: Icons.arrow_back_rounded,
                    onPressed: isFirstQuestion ? null : _goBack,
                  ),
                ),
                SizedBox(width: context.sz(12)),
                Expanded(
                  child: PrimaryButton(
                    text: isLastQuestion ? 'Submit' : 'Next',
                    icon: isLastQuestion
                        ? Icons.check_rounded
                        : Icons.arrow_forward_rounded,
                    onPressed: isLastQuestion ? _submitQuiz : _goNext,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
