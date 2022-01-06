import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_permission/get_permission.dart';
import 'package:get_permission/permission.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final cameraStatus =
        await Permissions.camera.checkStatus(Permissions.camera);
    debugPrint('Camera permission status $cameraStatus');

    final cameraAvailability =
        await Permissions.camera.checkAvailability(Permissions.camera);
    debugPrint('Camera permission availability status $cameraAvailability');

    final requestCameraStatus =
        await Permissions.camera.request(Permissions.camera);
    debugPrint('Camera request permission status $requestCameraStatus');

    final requestStatuses =
        await [Permissions.microphone, Permissions.contacts].request();
    for (var k in requestStatuses.keys) {
      debugPrint('Request permission - $k, status: ${requestStatuses[k]}');
    }

    final statuses =
        await [Permissions.microphone, Permissions.contacts].checkStatuses();
    for (var k in statuses.keys) {
      debugPrint('Permission - $k, status: ${statuses[k]}');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Get permissions access\n'),
        ),
      ),
    );
  }
}
