import 'package:flutter/material.dart';
import 'dart:async';

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
    final cameraStatus = await Permissions.camera.checkStatus();
    debugPrint('Camera permission status $cameraStatus');

    final cameraAvailability = await Permissions.camera.checkAvailability();
    debugPrint('Camera permission availability status $cameraAvailability');

    final requestCameraStatus = await Permissions.camera.request();
    debugPrint('Camera request permission status $requestCameraStatus');

    final requestStatuses =
        await [Permissions.microphone, Permissions.contacts].request();
    for (var k in requestStatuses.keys) {
      debugPrint('Request permission - $k, status: ${requestStatuses[k]}');
    }

    final requestNotificationWithOptions =
        await Permissions.notificationOptions.requestWithOptions([
      PermissionOption.notificationOptionAlert,
      PermissionOption.notificationOptionBadge,
      PermissionOption.notificationOptionSound,
      PermissionOption.notificationOptionCriticalAlert,
    ]);

    debugPrint(
        'Notification with options request permission status: $requestNotificationWithOptions');

    final requestNotificationStatuses = await [
      Permissions.notification,
      Permissions.notificationOptionAlert,
      Permissions.notificationOptionBadge,
      Permissions.notificationOptionSound,
      Permissions.notificationOptionCarPlay,
      Permissions.notificationOptionCriticalAlert,
      Permissions.notificationOptionProvisional,
      Permissions.notificationOptionAnnouncement,
      Permissions.notificationOptionTimeSensitive,
    ].request();
    for (var k in requestNotificationStatuses.keys) {
      debugPrint(
          'Request notification permission - $k, status: ${requestNotificationStatuses[k]}');
    }

    final statuses = await [
      Permissions.microphone,
      Permissions.contacts,
      Permissions.notification
    ].checkStatuses();
    for (var k in statuses.keys) {
      debugPrint('Permission - $k, status: ${statuses[k]}');
    }

    final eventStatuses = await [
      Permissions.calendar,
      Permissions.reminderIOS,
    ].request();
    for (var k in statuses.keys) {
      debugPrint(
          'Request event permission status - $k, status: ${eventStatuses[k]}');
    }

    final requestSpeechStatus = await Permissions.speech.request();
    debugPrint('Speech request permission status $requestSpeechStatus');

    final locationStatuses = await [
      Permissions.locationAlways,
      Permissions.locationWhenInUse,
    ].request();
    for (var k in statuses.keys) {
      debugPrint(
          'Request location permission status - $k, status: ${locationStatuses[k]}');
    }

    final photosStatuses = await [
      Permissions.photos,
      Permissions.photosWriteOnlyIOS,
    ].request();
    for (var k in statuses.keys) {
      debugPrint(
          'Request photo permission status - $k, status: ${photosStatuses[k]}');
    }

    final requestMediaLibraryStatus = Permissions.mediaLibrary.request();
    debugPrint(
        'Request media library permission status: $requestMediaLibraryStatus');

    final checkPhone = await Permissions.phone.checkAvailability();
    debugPrint('Phone permission availability status $checkPhone');

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
