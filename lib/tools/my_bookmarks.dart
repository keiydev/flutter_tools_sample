import 'package:flutter/material.dart';
import 'package:flutter_tools_sample/generated/i18n.dart';

class MyBookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = S.of(context).tools_list_title;
    return MaterialApp(
      title: S.of(context).app_name,
      home: Scaffold(
        appBar: AppBar(title: Text(title),),
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    const Text('I\'m dedicating every day to you'),
                    const Text('Domestic life was never quite my style'),
                    const Text('When you smile, you knock me out, I fall apart'),
                    const Text('And I thought I was so smart'),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

}
