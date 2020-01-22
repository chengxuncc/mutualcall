import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> log = <Widget>[];
  final channel = MethodChannel('example.com/greeting');

  @override
  void initState() {
    super.initState();
    channel.setMethodCallHandler((MethodCall call) async {
      print(call.method);
      print(call.arguments);
      return 'hi from dart';
    });
  }

  void _sendHello() {
    channel.invokeMethod('say', 'hello from dart').then((result) {
      setState(() {
        log.add(Text(result));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: log,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _sendHello,
          tooltip: 'add',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
