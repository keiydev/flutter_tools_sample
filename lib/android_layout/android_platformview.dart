import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tools_sample/generated/l10n.dart';
import 'package:toast/toast.dart';

// ref. https://programming.vip/docs/flutter-58-graphical-flutter-embedded-in-native-android-view-trial.html

class AndroidLinearLayoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlatformView on Android',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = "Android PlatformView";
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              child: Card(
                child: Text('FlutterView Card'),
                color: Colors.blueAccent,
              ),
            ),
            Container(
              child: Text('↓Android PlatformView↓'),
            ),
            Container(
                child: AndroidView(
                    viewType: "com.keiydev.flutter_tools_sample/method_layout",
                    creationParamsCodec: const StandardMessageCodec(),
                    creationParams: {'method_layout_size': 100}),
                color: Colors.pinkAccent,
                height: 100.0),
            Container(
                child: AndroidView(
                    viewType: "com.keiydev.flutter_tools_sample/method_layout",
                    creationParamsCodec: const StandardMessageCodec(),
                    creationParams: {'method_layout_size': 100}),
                color: Colors.greenAccent,
                height: 100.0),
            Container(
                height: 80.0,
                child: AndroidView(
                    onPlatformViewCreated: (id) async {
                      MethodChannel _channel =
                          const MethodChannel('ace_method_text_view');
                      _channel
                        ..invokeMethod('method_set_text', 'Method_Channel')
                        ..setMethodCallHandler((call) {
                          if (call.method == 'method_click') {
                            //_toast('Method Text FlutterToast!', context);
                            print('Method Text FlutterToast!');
                            Toast.show('Method Text FlutterToast!', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          }
                          return null; // void
                        });
                    },
                    viewType:
                        "com.keiydev.flutter_tools_sample/method_text_view",
                    creationParamsCodec: const StandardMessageCodec(),
                    creationParams: {
                      'method_text_str': 'Method Channel Params!!'
                    })),
            Container(
                height: 80.0,
                child: AndroidView(
                    hitTestBehavior: PlatformViewHitTestBehavior.translucent,
                    onPlatformViewCreated: (id) async {
                      BasicMessageChannel _channel = const BasicMessageChannel(
                          'ace_basic_text_view', StringCodec());
                      _channel
                        ..send("Basic_Channel")
                        ..setMessageHandler((message) {
                          if (message == 'basic_text_click') {
                            Toast.show('Basic Text FlutterToast!', context);
                          }
                          print('===${message.toString()}==');
                        });
                    },
                    viewType:
                        "com.keiydev.flutter_tools_sample/basic_text_view",
                    creationParamsCodec: const StandardMessageCodec(),
                    creationParams: {
                      'basic_text_str': 'Basic Channel Params!!'
                    })),
            Container(
                height: 80.0,
                child: AndroidView(
                    hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    onPlatformViewCreated: (id) async {
                      EventChannel _channel =
                          const EventChannel('ace_event_text_view');
                      _channel
                          .receiveBroadcastStream('Event_Channel')
                          .listen((message) {
                        if (message == 'event_text_click') {
                          Toast.show('Event Text FlutterToast!', context);
                        }
                      });
                    },
                    viewType:
                        "com.keiydev.flutter_tools_sample/event_text_view",
                    creationParamsCodec: const StandardMessageCodec(),
                    creationParams: {
                      'event_text_str': 'Event Channel Params!!'
                    })),
            Container(
                height: 750.0,
                child: GestureDetector(
                    child: AndroidView(
                        gestureRecognizers: Set()
                          ..add(Factory<VerticalDragGestureRecognizer>(
                              () => VerticalDragGestureRecognizer()))
                          ..add(Factory<LongPressGestureRecognizer>(
                              () => LongPressGestureRecognizer())),
                        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                        onPlatformViewCreated: (id) async {
                          MethodChannel _channel =
                              const MethodChannel('ace_method_list_view');
                          _channel
                            ..invokeMethod('method_set_list', 15)
                            ..setMethodCallHandler((call) {
                              if (call.method == 'method_item_click') {
                                Toast.show(
                                    'List FlutterToast! position -> ${call.arguments}',
                                    context);
                              } else if (call.method ==
                                  'method_item_long_click') {
                                Toast.show(
                                    'List FlutterToast! -> ${call.arguments}',
                                    context);
                              }
                            });
                        },
                        viewType:
                            "com.keiydev.flutter_tools_sample/method_list_view",
                        creationParamsCodec: const StandardMessageCodec(),
                        creationParams: {'method_list_size': 10}))),
            Container(
              child: Text('↑Android PlatformView↑'),
            ),
            Container(
              child: Card(
                child: Text('FlutterView Card'),
                color: Colors.blueAccent,
              ),
            ),
          ]),
        ));
  }
}
