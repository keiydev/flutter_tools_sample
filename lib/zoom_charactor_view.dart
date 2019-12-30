import 'package:flutter/material.dart';
import 'package:flutter_tools_sample/generated/i18n.dart';
import 'package:google_fonts/google_fonts.dart';

class ZoomCharacterPage extends StatelessWidget {
  static BuildContext _pageContext;

  @override
  Widget build(BuildContext context) {
    _pageContext = context;
    return ZoomCharacter();
  }
}

class ZoomCharacter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ZoomCharacterState();
  }
}

class ZoomCharacterState extends State<ZoomCharacter> {
  TextEditingController _textEditingController =
      TextEditingController(text: 'あ');
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = S.of(context).show_zoom_character;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: TextField(
        controller: _textEditingController,
        style: GoogleFonts.notoSerifJP(fontSize: 200),
        strutStyle: StrutStyle(
          fontSize: 200.0,
          height: 1.5,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ZoomCharacterPage2(_textEditingController.text)));
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}

class ZoomCharacterPage2 extends StatelessWidget {
  static BuildContext _pageContext;
  String myText;
  ZoomCharacterPage2(this.myText) {}

  @override
  Widget build(BuildContext context) {
    _pageContext = context;
    return ZoomCharacter2(myText: myText);
  }
}

class ZoomCharacter2 extends StatefulWidget {
  String myText;
  ZoomCharacter2({this.myText}) : super();

  @override
  State<StatefulWidget> createState() {
    return ZoomCharacterState2();
  }
}

class ZoomCharacterState2 extends State<ZoomCharacter2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = S.of(context).show_zoom_character;
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        widget.myText,
        style: GoogleFonts.notoSerifJP(fontSize: 410),
      ),
    ));
  }
}
