import 'package:flutter/material.dart';
import 'package:test_app/colors.dart';
import 'package:test_app/settings/darkThemeSwitch.dart';
import 'package:test_app/settings/theme.dart';

class ThirdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Icon(
                Icons.settings,
                size: 160.0,
              ),
              Text(
                "Настройки",
                style: Theme.of(context).textTheme.headline5,),
            ],
          ),
        ),
      ),
    );
  }
}
