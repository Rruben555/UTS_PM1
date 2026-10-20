import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_body.dart';
import '../widgets/theme_toggle.dart';
import 'quiz_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RestorationMixin {
  final RestorableTextEditingController _nameController =
      RestorableTextEditingController();

  final RestorableString _savedName = RestorableString('');

  @override
  String? get restorationId => 'home_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_nameController, 'name_controller');
    registerForRestoration(_savedName, 'saved_name');
    _nameController.value.addListener(_updateSavedName);
    _updateSavedName();
  }

  void _updateSavedName() {
    _savedName.value = _nameController.value.text;
  }

  void _startQuiz() {
    final name = _nameController.value.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan nama terlebih dahulu.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => QuizPage(userName: name),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.value.removeListener(_updateSavedName);
    _nameController.dispose();
    _savedName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final double fieldRadius = context.sz(16);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fun Quiz'),
        actions: const [
          ThemeToggle(),
        ],
      ),
      body: ResponsiveBody(
        centerVertically: true,
        verticalPadding: 24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.sz(16),
                  vertical: context.sz(8),
                ),
                decoration: BoxDecoration(
                  color: c.accentSoft,
                  borderRadius: BorderRadius.circular(context.sz(30)),
                ),
                child: Text(
                  'FUN QUIZ',
                  style: TextStyle(
                    color: c.accentSoftText,
                    fontSize: context.sp(12),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.sz(20)),
            Center(
              child: Text(
                'Uji Pengetahuanmu!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.sp(28),
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
            ),
            SizedBox(height: context.sz(12)),
            Center(
              child: Text(
                'Jawab pertanyaan, kumpulkan poin, '
                'dan lihat seberapa hebat dirimu.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.sp(14),
                  height: 1.7,
                  color: c.textSecondary,
                ),
              ),
            ),
            SizedBox(height: context.sz(32)),
            Text(
              'Siapa namamu?',
              style: TextStyle(
                fontSize: context.sp(15),
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
            SizedBox(height: context.sz(12)),
            TextField(
              controller: _nameController.value,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _startQuiz(),
              style: TextStyle(
                fontSize: context.sp(15),
                color: c.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Masukkan nama kamu',
                hintStyle: TextStyle(
                  fontSize: context.sp(15),
                  color: c.textHint,
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.primary,
                  size: context.sz(24),
                ),
                filled: true,
                fillColor: c.surface,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.sz(18),
                  vertical: context.sz(18),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(fieldRadius),
                  borderSide: BorderSide(color: c.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(fieldRadius),
                  borderSide: BorderSide(color: c.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(fieldRadius),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.sz(20)),
            PrimaryButton(
              text: 'Mulai Quiz',
              icon: Icons.arrow_forward_rounded,
              onPressed: _startQuiz,
            ),
            SizedBox(height: context.sz(20)),
            Center(
              child: Text(
                'Siap untuk tantangan hari ini?',
                style: TextStyle(
                  fontSize: context.sp(12),
                  color: c.textHint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
