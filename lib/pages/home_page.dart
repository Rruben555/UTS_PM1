import 'package:flutter/material.dart';

import '../widgets/primary_button.dart';
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
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.07,
                vertical: 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE1F7F3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: Color(0xFF16A6A1),
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'LET’S PLAY & LEARN',
                              style: TextStyle(
                                color: Color(0xFF138A86),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.025),
                    const Center(
                      child: Text(
                        'Uji Pengetahuanmu!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF202B3C),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'Jawab pertanyaan, kumpulkan poin, '
                        'dan lihat seberapa hebat dirimu.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.7,
                          color: Color(0xFF7B8798),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Siapa namamu?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF202B3C),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController.value,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _startQuiz(),
                      decoration: InputDecoration(
                        hintText: 'Masukkan nama kamu',
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF16A6A1),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFF16A6A1),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Mulai Quiz',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: _startQuiz,
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Siap untuk tantangan hari ini?',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9AA5B4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
