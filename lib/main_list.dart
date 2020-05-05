import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tools_sample/android_layout/android_layout_list.dart';
import 'package:flutter_tools_sample/experimental/listview.dart';
import 'package:flutter_tools_sample/generated/i18n.dart';
import 'package:flutter_tools_sample/tools/Calculator.dart';
import 'package:flutter_tools_sample/zoom_charactor_view.dart';
import 'package:package_info/package_info.dart';

class ToolsListPage extends StatelessWidget {
  static BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    final title = S.of(context).tools_list_title;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(children: listTiles),
    );
  }

  final List<Widget> listTiles = <Widget>[
    Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black26),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.dialpad),
          title: Builder(
              builder: (context) => Text(S.of(context).tools_my_calculator)),
          onTap: () {
            Navigator.push(_context,
                MaterialPageRoute(builder: (context) => CalculatorPage()));
          },
        )),
    Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black26),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.text_format),
          title: Builder(
              builder: (context) => Text(S.of(context).show_zoom_character)),
          onTap: () {
            Navigator.push(_context,
                MaterialPageRoute(builder: (context) => ZoomCharacterPage()));
          },
        )),
    /*
    Container(
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(color: Colors.black26),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.map),
          title: Builder(builder: (context) => Text(S.of(context).tools_my_bookmarks)),
          onTap: () {openDialog(_context, 0);},
        )
    ),*/
    Platform.isAndroid
        ? Container(
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(color: Colors.black26),
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.android),
              title: Builder(
                  builder: (context) => Text(Platform.isAndroid
                      ? S.of(context).android_layout_list_title
                      : 'not supported this device')),
              enabled: Platform.isAndroid,
              onTap: () {
                Navigator.push(
                    _context,
                    MaterialPageRoute(
                        builder: (context) => AndroidLayoutListPage()));
              },
            ))
        : Container(),
    Container(
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(color: Colors.black26),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.android),
          title: Text(Platform.isAndroid
              ? 'Start Android Screen'
              : 'not supported this device'),
          enabled: Platform.isAndroid,
          onTap: () {
            openDialog(_context, 1);
          },
        )),
    Container(
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(color: Colors.black26),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.phone_iphone),
          title: Text(Platform.isIOS
              ? 'Start iOS Settings'
              : 'not supported this device'),
          enabled: Platform.isIOS,
          onTap: () {
            openDialog(_context, 1);
          },
        )),
    Container(
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(color: Colors.black26),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('About'),
          onTap: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            showAboutDialog(
                context: _context,
                applicationName: S.of(_context).app_name,
                //applicationVersion: "v1.0.0",
                applicationVersion: packageInfo.version,
                applicationIcon: Image.asset('res/images/launcher_icon.png',
                    height: 64.0, width: 64.0),
                children: <Widget>[
                  Text(S.of(_context).about_description +
                      "\nappName=${packageInfo.appName}"
                          "\npackageName=${packageInfo.packageName}"
                          "\nversion=${packageInfo.version}"
                          "\nbuildNumber=${packageInfo.buildNumber}")
                ]);
          },
        )),
  ];

  static void openDialog(BuildContext context, int dialogId) {
    StatelessWidget nextPage;
    Text title = Text('SimpleDialog');
    switch (dialogId) {
      case 0:
        nextPage = ListViewPage();
        title = Text('Open ListView');
        break;
      case 1:
        title = Text('Open Native Screen');
        break;
    }
    showDialog<Answers>(
      context: context,
      builder: (BuildContext context) => new SimpleDialog(
        title: title,
        children: <Widget>[
          createDialogOption(context, Answers.YES, S.of(context).common_yes),
          createDialogOption(context, Answers.NO, S.of(context).common_no)
        ],
      ),
    ).then((value) {
      switch (value) {
        case Answers.YES:
          //_setValue('Yes');
          switch (dialogId) {
            case 0:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => nextPage));
              break;
            case 1:
              _launchNativeScreen();
              break;
          }
          break;
        case Answers.NO:
          //_setValue('No');
          break;
      }
    });
  }

  static createDialogOption(BuildContext context, Answers answer, String str) {
    return new SimpleDialogOption(
      child: Text(str),
      onPressed: () {
        Navigator.pop(context, answer);
      },
    );
  }
}

enum Answers { YES, NO }

// MethodChannelには任意の名前をつけることができますが、慣習的にパッケージ名をprefixに使うようです
MethodChannel _methodChannel =
    MethodChannel('com.keiydev.flutter_tools_sample/method');

// ネイティブへのメッセージ送信＞画面遷移
Future<Null> _launchNativeScreen() async {
  // ネイティブ側へメッセージを送信
  await _methodChannel.invokeMethod('launchNativeScreen', "parameters");
}
