import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_tools_sample/generated/i18n.dart';

class ListViewPage extends StatelessWidget {
  static BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    final title = 'ListView page';
    return MaterialApp(
      title: S
          .of(context)
          .app_name,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ja', ''),
      ],
      home: Scaffold(
        appBar: AppBar(title: Text(title),),
        body: HomeWidget(),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

class ListState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Text(index.toString());
      },
      itemCount: 11,);
  }
}
