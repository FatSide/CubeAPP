import 'package:flutter/material.dart';
import '../Get_Lessons_test.dart';
import 'package:test_app/colors.dart';
import 'package:test_app/settings/darkThemeSwitch.dart';
import 'package:test_app/settings/theme.dart';

class FirstTab_test extends StatefulWidget {
  @override
  _FirstTab_testState createState() => _FirstTab_testState();
}

class _FirstTab_testState extends State<FirstTab_test> {
  late Future<List<Lesson>> _lessonsFuture;
  final String groupName = "Группа 32/1";
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _lessonsFuture = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Lesson>>(
        future: _lessonsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка загрузки данных'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет данных'));
          }

          // Группируем занятия по датам
          Map<String, List<Lesson>> groupedLessons = {};
          for (var lesson in snapshot.data!) {
            groupedLessons.putIfAbsent(lesson.date, () => []).add(lesson);
          }

          return ListView(
            padding: EdgeInsets.all(8.0),
            children: [

              Card(
                color: Theme.of(context).cardTheme.color,
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ExpansionTile(
                  initiallyExpanded: isExpanded,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      isExpanded = expanded;
                    });
                  },
                  title: Text(
                    groupName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  children: [

                    ...groupedLessons.entries.map((entry) {
                      String date = entry.key;
                      List<Lesson> lessons = entry.value;

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Дата занятия
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 8.0),

                            ...lessons.map((lesson) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [

                                        Text(
                                          "${lesson.number}. ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue,
                                          ),
                                        ),

                                        Expanded(
                                          child: Text(
                                            '${lesson.subject} (${lesson.room})',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 24.0),
                                      child: Text(
                                        lesson.teacher,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
