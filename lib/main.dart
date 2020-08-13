import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_tools_sample/common/const_vars.dart';
import 'package:flutter_tools_sample/generated/l10n.dart';
import 'package:flutter_tools_sample/main_list.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('res/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリタイトル(8.0以前は履歴画面のタイトルに使用される。)
      onGenerateTitle: (BuildContext context) => S.of(context).app_name,
      // アプリのテーマ設定
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // アプリのローカリゼーション設定
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // アプリのサポートするロケール種別設定
      supportedLocales: S.delegate.supportedLocales,
      // アプリの画面widget設定
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar：アプリ画面のバー
      appBar: AppBar(
        // アプリ画面上部のバーのタイトル
        title: Text(S.of(context).app_name),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 16,
                bottom: 10,
              ),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              )),
        ),
      ),
      // body：アプリ画面のバー
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Text(S.of(context).main_explain_message),
            ),
            InkWell(
              child: Text(
                MY_APP_GIT_URL,
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                if (await canLaunch(MY_APP_GIT_URL)) {
                  await launch(MY_APP_GIT_URL);
                }
              },
            ),
            Text(''),
            Text(
              S.of(context).main_start_button_message,
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            RaisedButton(
              child: Text(S.of(context).common_start),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ToolsListPage()));
              },
              color: Colors.blueGrey,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
