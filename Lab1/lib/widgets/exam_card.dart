import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback? onTap;

  const ExamCard({super.key, required this.exam, this.onTap});

  String _shortTimeLeft() {
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);
    if (diff.isNegative) return "Испитот е поминат";
    final days = diff.inDays;
    final hours = diff.inHours.remainder(24);
    return "${days} дена, ${hours} часа";
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd.MM.yyyy').format(exam.dateTime);
    final timeStr = DateFormat('HH:mm').format(exam.dateTime);
    final isPast = exam.dateTime.isBefore(DateTime.now());

    final cardColor = isPast ? Colors.grey.shade200 : Colors.white;
    final accent = isPast ? Colors.grey : Colors.blue.shade200;

    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: accent.withOpacity(0.12),
                child: Icon(Icons.school, color: Colors.blue.shade200),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isPast ? Colors.black54 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 6),
                        Text(dateStr),
                        const SizedBox(width: 12),
                        const Icon(Icons.access_time, size: 16),
                        const SizedBox(width: 6),
                        Text(timeStr),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 6),
                        Flexible(child: Text(exam.rooms.join(", "))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _shortTimeLeft(),
                      style: TextStyle(
                        fontSize: 13,
                        color: isPast ? Colors.grey : Colors.blue.shade200,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
