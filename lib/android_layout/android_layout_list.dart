import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tools_sample/android_layout/android_platformview.dart';
import 'package:flutter_tools_sample/experimental/listview.dart';
import 'package:flutter_tools_sample/generated/i18n.dart';
import 'package:flutter_tools_sample/main_list.dart';
import 'package:flutter_tools_sample/tools/Calculator.dart';
import 'package:package_info/package_info.dart';

class AndroidLayoutListPage extends StatelessWidget {
  static BuildContext _pageContext;
  @override
  Widget build(BuildContext context) {
    _pageContext = context;
    final title = S.of(context).android_layout_list_title;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(children: listTiles));
  }

  final List<Widget> listTiles = <Widget>[
    Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black26))),
        child: ListTile(
          title: Text("Android PlatformView"),
          onTap: () {
            Navigator.push(
                _pageContext,
                MaterialPageRoute(
                    builder: (context) => AndroidLinearLayoutPage()));
          },
        )),
  ];
}
