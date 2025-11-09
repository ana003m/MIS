import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import 'exam_detail_screen.dart';

class ExamListScreen extends StatefulWidget {
  const ExamListScreen({super.key});

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen> {
  final String studentIndex = "221200";

  late final List<Exam> exams;

  @override
  void initState() {
    super.initState();
    exams = _buildExams()..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  List<Exam> _buildExams() {
    final now = DateTime.now();
    return [
      Exam(
          name: "Структурно програмирање",
          dateTime: DateTime(now.year, now.month, now.day - 10, 12, 30),
          rooms: ["ЛАБ 200АБ"]
      ),
      Exam(
          name: "Калкулус",
          dateTime: DateTime(now.year, now.month, now.day - 3, 15, 0),
          rooms: ["АМФ ФИНКИ Г"]
      ),
      Exam(
          name: "Алгоритми и податочни структури",
          dateTime: DateTime(now.year, now.month, now.day + 2, 10, 0),
          rooms: ["ЛАБ 3", "ЛАБ 13", "ЛАБ 138"]
      ),
      Exam(
          name: "ООП",
          dateTime: DateTime(now.year, now.month, now.day + 4, 8, 0),
          rooms: ["ЛАБ 2", "ЛАБ 3", "ЛАБ 13", "ЛАБ 138"]
      ),
      Exam(
          name: "Бази на податоци",
          dateTime: DateTime(now.year, now.month, now.day + 6, 14, 0),
          rooms: ["ЛАБ 2", "ЛАБ 3", "ЛАБ 13", "ЛАБ 138"]
      ),
      Exam(
          name: "Компјутерски мрежи",
          dateTime: DateTime(now.year, now.month, now.day + 8, 9, 30),
          rooms: ["ЛАБ 2", "ЛАБ 3", "ЛАБ 13", "ЛАБ 138", "ЛАБ 117"]
      ),
      Exam(
          name: "Веб програмирање",
          dateTime: DateTime(now.year, now.month, now.day + 10, 11, 0),
          rooms: ["ЛАБ 2", "ЛАБ 3"]
      ),
      Exam(
          name: "Оперативни системи",
          dateTime: DateTime(now.year, now.month, now.day + 12, 13, 0),
          rooms: ["ЛАБ 2", "ЛАБ 3", "ЛАБ 13", "ЛАБ 138"]
      ),
      Exam(
          name: "Мобилни информациски системи",
          dateTime: DateTime(now.year, now.month, now.day + 14, 10, 30),
          rooms: ["АМФ МФ"]
      ),
      Exam(
          name: "Дискретна математика",
          dateTime: DateTime(now.year, now.month, now.day + 20, 12, 0),
          rooms: ["223 ФЕИТ", "АМФ ФИНКИ Г"]
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Распоред за испити - $studentIndex"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        itemCount: exams.length,
        itemBuilder: (context, index) {
          final exam = exams[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ExamDetailScreen(exam: exam)));
            },
            child: ExamCard(exam: exam),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Вкупно испити: ${exams.length}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
