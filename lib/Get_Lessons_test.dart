import 'package:http/http.dart' as http;
import 'dart:convert';

class Lesson {
  final String subject;  // Название предмета
  final String type;     // Тип предмета
  final String teacher;  // ФИО преподавателя
  final String room;     // Название аудитории
  final int number;      // Номер занятия
  final String date;     // Дата занятия

  Lesson({
    required this.subject,
    required this.type,
    required this.teacher,
    required this.room,
    required this.number,
    required this.date,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      subject: json['discipline'] != null && json['discipline']['short_name'] != null
          ? json['discipline']['short_name']
          : '-',
      teacher: json['teachers'] != null && json['teachers'].isNotEmpty
          ? json['teachers'][0]['short_name']
          : '-',
      room: json['place'] != null && json['place']['name'] != null
          ? json['place']['name']
          : '-',
      type: json['type'] != null && json['type']['short_name'] != null
          ? json['type']['short_name']
          : '-',
      number: json['number'] ?? 0,
      date: json['date'] ?? '-',
    );
  }
}

Future<List<Lesson>> getData() async {
  final response = await http.get(Uri.parse(
      'https://api.test.nlabs.su/api/timetable/lessons/viewer?start_date=2025-03-10&end_date=2025-03-16&faculty_id=1&group=669&is_bot=false'));

  if (response.statusCode == 200) {
    var decodedBody = utf8.decode(response.bodyBytes);

    Map<String, dynamic> jsonResponse = json.decode(decodedBody);

    List<dynamic> jsonList = jsonResponse['data'] ?? [];
    List<Lesson> lessons = jsonList.map((json) => Lesson.fromJson(json)).toList();

///////////////////////////////////////////////////////////////////////////////////
    if (lessons.isNotEmpty) {
      print('Информация о занятиях:');
      for (var lesson in lessons) {
        print('---------------------------------');
        print('Предмет: ${lesson.subject}');
        print('Тип занятия: ${lesson.type}');
        print('Преподаватель: ${lesson.teacher}');
        print('Аудитория: ${lesson.room}');
        print('Номер занятия: ${lesson.number}');
        print('Дата занятия: ${lesson.date}');
        print('---------------------------------');
      }
    } else {
      print('Занятия не найдены.');
    }
///////////////////////////////////////////////////////////////////////////////////

    return lessons;
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}