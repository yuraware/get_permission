import 'dart:async';

import 'package:flutter/services.dart';

class GetPermission {
  static const MethodChannel _channel = MethodChannel('get_permission');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Status> get status => Future.delayed(Duration.zero, () async {
        return Status.granted;
      });
  Future<Status> checkStatus(Permissions permission) async {
    final status = await _channel.invokeMethod('checkPermission', permission);

    return status;
  }
}

enum Permissions {
  calendar,
  camera,
  contacts,
  location,
  locationWhenInUse,
  locationAlways,
  mediaLibrary,
  microphone,
  phoneAndroid,
  photos,
  photosWriteOnlyIOS,
  remindersIOS,
  sensors,
  smsAndroid,
  speech,
  storage,
  ignoreBatteryOptimizationsAndroid,
  notification,
  mediaLocation,
  activityRecognitionAndroid,
  bluetooth,
  manageExternalStorageAndroid,
  systemAlertWindowAndroid,
  requestInstallPackageAndroid,
  appTrackingTransparentcyIOS,
  criticalAlertsIOS,
  accessNotificationPolicyAndroid,
  bluetoothScanAndroid,
  bluetoothAdvertiseAndroid,
  bluetoothConnectAndroid,
  unknown,
}

enum Status {
  denied,
  granted,

  restrictedIOS,
  limitedIOS,
  permanentlyDeniedAndroid,
}

class Permission {}
