import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({super.key, required this.exam});

  String _timeUntilExam() {
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);
    if (diff.isNegative) return "Испитот е завршен";
    final days = diff.inDays;
    final hours = diff.inHours.remainder(24);
    return "$days дена, $hours часа";
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd.MM.yyyy').format(exam.dateTime);
    final timeStr = DateFormat('HH:mm').format(exam.dateTime);
    final isPast = exam.dateTime.isBefore(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.name),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Card(
            elevation: 6,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: Colors.blue.shade100, width: 1.6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      exam.name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, color: Colors.black54),
                      const SizedBox(width: 10),
                      Text("Датум: $dateStr", style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time_outlined, color: Colors.black54),
                      const SizedBox(width: 10),
                      Text("Време: $timeStr", style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.black54),
                      const SizedBox(width: 10),
                      Expanded(child: Text("Простории: ${exam.rooms.join(', ')}", style: const TextStyle(fontSize: 16))),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: Text(
                      isPast ? "Испитот е завршен" : "Преостанува: ${_timeUntilExam()}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isPast ? Colors.redAccent : Colors.blue.shade200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (isPast)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Center(child: Text("Овој испит е поминат.", style: TextStyle(color: Colors.grey))),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
