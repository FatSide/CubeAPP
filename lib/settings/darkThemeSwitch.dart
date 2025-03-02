import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/colors.dart';

class darkThemeSwitch extends StatefulWidget {
  const darkThemeSwitch({Key? key}) : super(key: key);
  @override
  State<darkThemeSwitch> createState() => _darkThemeSwitchState();
}

class _darkThemeSwitchState extends State<darkThemeSwitch> {
  Color iconTextColor(){
    if (isSwitched){
      return Colors.white;
    }
    else return verylightblue;
  }
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
          ),
        ],
      ),
    );
  }
}