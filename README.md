<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# get_permission
Flutter plugin for permissions handling on iOS and Android.

## Features

- [x] get statuses of permissions
- [x] request single/multiple permissions
- [x] request notification permissions on iOS 
- [x] handle permissions on iOS
- [ ] handle permissions on Android

#### Supported platforms
- [x] iOS
- [ ] Android

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

`enum Permissions` contains all declared permissions.

To request a single permission call:
```
final requestCameraStatus = await Permissions.camera.request();
if (requestCameraStatus == Status.authorized) { /* Do something */ }
```

Requesting multiple permissions:
```
final eventStatuses = await [
      Permissions.calendar,
      Permissions.reminderIOS,
    ].request();
for (var k in statuses.keys) {
    debugPrint('Request event permission status - $k, status: ${eventStatuses[k]}');
}
```

Check status of a sing permission:
```
final cameraStatus = await Permissions.camera.checkStatus();
if (cameraStatus == Status.authorized) { /* Do something */ }
```

Check status of multiple permissions:
```
final statuses = await [
      Permissions.microphone,
      Permissions.contacts,
      Permissions.notification
    ].checkStatuses();
for (var k in statuses.keys) {
    debugPrint('Permission - $k, status: ${statuses[k]}');
}
```

Check availability of permission on a phone capability example:
```
final checkPhone = await Permissions.phone.checkAvailability();
```

## Additional information

TODO: Find matching permissions iOS / Android to the Flutter package PermissionType.
