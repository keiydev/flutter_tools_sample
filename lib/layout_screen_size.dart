import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_tools_sample/android_layout/android_layout_list.dart';
import 'package:flutter_tools_sample/experimental/listview.dart';
import 'package:flutter_tools_sample/generated/l10n.dart';
import 'package:flutter_tools_sample/tools/Calculator.dart';
import 'package:package_info/package_info.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

double screenHeight(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenHeightExcludingToolbar(BuildContext context,
    {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}

class LayoutScreenSizePage extends StatelessWidget {
  static BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    final title = S.of(context).tools_list_title;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ScreenSizeWidget(),
    );
  }
}

class ScreenSizeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScreenSizeWidgetState();
  }
}

class _ScreenSizeWidgetState extends State<ScreenSizeWidget> {
  GlobalKey _keyFirst = GlobalKey();
  Size _NscreenSize = Size(0, 0);
  Size _FirstWidgetSize = Size(0, 0);

  _ScreenSizeWidgetState() {
    _getDisplaySize().then((val) => setState(() {
          _NscreenSize = val;
        }));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _getSizes();
    //_getPositions();
  }

  _getSizes() {
    final RenderBox renderBoxFirst =
        _keyFirst.currentContext.findRenderObject();
    _FirstWidgetSize = renderBoxFirst.size;
    print("SIZE of First: $_FirstWidgetSize");
    setState(() {
      print("${_FirstWidgetSize.height} x ${_FirstWidgetSize.width}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        key: _keyFirst,
        color: Colors.blue[200],
        height: screenHeightExcludingToolbar(context, dividedBy: 2),
        width: screenHeightExcludingToolbar(context),
        child: Text(
          "○DP(window.devicePixelRatio) = " +
              window.devicePixelRatio.toString() +
              "\n○window.physicalSize(px): height x width = " +
              window.physicalSize.height.toString() +
              " x " +
              window.physicalSize.width.toString() +
              "\n○MediaQuery size(dp): height x width = " +
              screenHeight(context).toString() +
              " x " +
              screenWidth(context).toString() +
              "\n○Flutter Toolbar height(kToolbarHeight)(dp): height = " +
              kToolbarHeight.toString() +
              "\n○View size(dp): height x width = " +
              _FirstWidgetSize.height.toString() +
              " x " +
              _FirstWidgetSize.width.toString() +
              "\n○Android screen size from Native API(px): height x width = " +
              _NscreenSize.height.toString() +
              " x " +
              _NscreenSize.width.toString() +
              "\n○MediaQuery textScaleFactor = " +
              MediaQuery.of(context).textScaleFactor.toString(),
          style:
              // fixed font size
              TextStyle(fontSize: 14 / MediaQuery.of(context).textScaleFactor),
        ),
      ),
      Container(
          color: Colors.yellow[200],
          height: screenHeightExcludingToolbar(context, dividedBy: 3))
    ]);
  }
}

// MethodChannelには任意の名前をつけることができますが、慣習的にパッケージ名をprefixに使うようです
MethodChannel _methodChannel =
    MethodChannel('com.keiydev.flutter_tools_sample/method');

Future<Size> _getDisplaySize() async {
  double width = (await _getDisplayWidth()).toDouble();
  double height = (await _getDisplayHeight()).toDouble();
  Size size = Size(width, height);
  return size;
}

// ネイティブへのメッセージ送信＞画面遷移
Future<int> _getDisplayHeight() async {
  // ネイティブ側へメッセージを送信
  return await _methodChannel.invokeMethod('getDisplayHeight');
}

// ネイティブへのメッセージ送信＞画面遷移
Future<int> _getDisplayWidth() async {
  // ネイティブ側へメッセージを送信
  return await _methodChannel.invokeMethod('getDisplayWidth');
}
