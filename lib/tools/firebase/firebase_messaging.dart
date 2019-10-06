// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
    ..status = data['status'];
  return item;
}

class Item {
  Item({this.itemId});
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return MaterialPageRoute<void>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => DetailPage(itemId),
    );
  }
}

class DetailPage extends StatefulWidget {
  DetailPage(this.itemId);
  final String itemId;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Item _item;
  StreamSubscription<Item> _subscription;

  @override
  void initState() {
    super.initState();
    _item = _items[widget.itemId];
    _subscription = _item.onChanged.listen((Item item) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _item = item;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item ${_item.itemId}"),
      ),
      body: Material(
        child: Center(child: Text("Item status: ${_item.status}")),
      ),
    );
  }
}

class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

final Completer<Map<String, dynamic>> _completer =
    Completer<Map<String, dynamic>>();

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print("onBackgroundMessage: $message");
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }
  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  // Or do other work.
  _completer.complete(message);
}

class _PushMessagingExampleState extends State<PushMessagingExample> {
  String _homeScreenText = "Waiting for token...";
  bool _topicButtonsDisabled = false;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _topicController =
      TextEditingController(text: 'all');

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text("Item ${item.itemId} has been updated"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
        _completer.complete(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
        _completer.complete(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
        _completer.complete(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Push Messaging Demo'),
        ),
        // For testing -- simulate a message being received
        floatingActionButton: FloatingActionButton(
          onPressed: () => sendAndRetrieveMessage(),
          tooltip: 'Simulate Message',
          child: const Icon(Icons.message),
        ),
        body: Material(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(_homeScreenText),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: TextField(
                      controller: _topicController,
                      onChanged: (String v) {
                        setState(() {
                          _topicButtonsDisabled = v.isEmpty;
                        });
                      }),
                ),
                FlatButton(
                  child: const Text("subscribe"),
                  onPressed: () {
                    if (_topicButtonsDisabled) {
                      print("subscribe button disabled");
                    } else {
                      print("subscribe clicked");
                      _firebaseMessaging
                          .subscribeToTopic(_topicController.text);
                      //_clearTopicText();
                    }
                  },
                ),
                FlatButton(
                  child: const Text("unsubscribe"),
                  onPressed: () {
                    if (_topicButtonsDisabled) {
                      print("unsubscribe button disabled");
                    } else {
                      print("unsubscribe  clicked");
                      _firebaseMessaging
                          .unsubscribeFromTopic(_topicController.text);
                      //_clearTopicText();
                    }
                  },
                ),
              ]),
              Center(
                child: Text(
                    "\nTest steps:\nStep1. Check internet connectivity\n"
                    "Step2. Check the token was obtained\n"
                    "Step3. Subscribe topic-name 'all'\n"
                    "Step4. Send messaging from other device, exmple follows:\n"
                    '\$ DATA=\'{"notification": {"body": "this is a body","title": "this is a title"}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1"}, "to": "/topics/all"}\'\n'
                    '\$ curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "\$DATA" -H "Authorization: key=<server key>"\n'),
              ),
              Container(alignment: Alignment.topLeft, child: Text("Ref.")),
              InkWell(
                child: Text(
                  "https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_messaging/example",
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () async {
                  if (await canLaunch(
                      "https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_messaging/example")) {
                    await launch(
                        "https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_messaging/example");
                  }
                },
              ),

              //InkW
            ],
          ),
        ));
  }

  void _clearTopicText() {
    setState(() {
      _topicController.text = "";
      _topicButtonsDisabled = true;
    });
  }

  // Replace with server token from firebase console settings.
  //final String serverToken = '<Server-Token>';
  final String serverToken =
      'AAAAWtFRJ1M:APA91bHN_HqAVtBFWnLj-Tg1ZrYObgih9P8sUUazWt7FDtBu_XN5Zsxz42dOWTLR5DwWTb30wVmUmVOZW95Gag86hprqfSePHkqN66o2C2e0kGQYGjFOXqdrqUjDHWgiDM4j7lTQfAz9';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    print("send fcm message");
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': '/topics/${_topicController.text}',
        },
      ),
    );

    //final Completer<Map<String, dynamic>> completer =
    //    Completer<Map<String, dynamic>>();

    /*
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
        _completer.complete(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
        _completer.complete(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
        _completer.complete(message);
      },
    );
     */

    return _completer.future;
  }
}
