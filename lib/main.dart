import 'dart:async';

import 'package:flutter/material.dart';
import 'package:battery/battery.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Battery Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BatteryDemo(),
    );
  }
}

class BatteryDemo extends StatefulWidget {
  @override
  _BatteryDemoState createState() => _BatteryDemoState();
}

class _BatteryDemoState extends State<BatteryDemo> {
  final Battery _battery = Battery();
  late int _batteryLevel;
  late StreamSubscription<BatteryState> _batterySubscription;

  @override
  void initState() {
    super.initState();
    _batteryLevel = -1;
    _batterySubscription = _battery.onBatteryStateChanged.listen((BatteryState state) {
      _updateBatteryLevel();
    });
    _updateBatteryLevel();
  }

  @override
  void dispose() {
    _batterySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateBatteryLevel() async {
    final int level = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Battery Level:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_batteryLevel%',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
