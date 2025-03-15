import 'package:flutter/material.dart';
import 'package:test_app/colors.dart';
import 'package:test_app/settings/theme.dart';
import 'package:test_app/settings/thememanager.dart';
import '/tabs/first.dart';
import '/tabs/second.dart';
import '/tabs/third.dart';
import 'Get_Lessons_test.dart';
import 'package:test_app/test_tabs/first.dart';

void main() async {
  runApp(App());
  await getData();
}

ThemeManager _themeManager = ThemeManager();

class App extends StatefulWidget{

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener(){
    if(mounted){
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test app',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

// SingleTickerProviderStateMixin используется для анимации перехода
class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Switch(value: _themeManager.themeMode == ThemeMode.dark, onChanged: (newValue){
          _themeManager.toggleTheme(newValue);
        })],
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("КУБ.Расписание", style: Theme.of(context).textTheme.headline6,),
      ),
      body: TabBarView(
        children: <Widget>[FirstTab_test(), SecondTab(), ThirdTab()],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        child: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.timelapse,color: Theme.of(context).iconTheme.color,),
            ),
            Tab(
              icon: Icon(Icons.search,color: Theme.of(context).iconTheme.color,),
            ),
            Tab(
              icon: Icon(Icons.settings,color: Theme.of(context).iconTheme.color,),
            ),
          ],
          controller: controller,
        ),
      ),
    );
  }
}
