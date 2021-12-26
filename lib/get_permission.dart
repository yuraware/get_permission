import 'dart:async';

import 'package:flutter/services.dart';

class GetPermission {
  static const MethodChannel _channel = MethodChannel('get_permission');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Status> checkStatus(Permissions permission) async {
    final status =
        await _channel.invokeMethod('checkPermission', permission.index);
    return StatusParser.statusFrom(status);
  }

  static Future<Availability> checkAvailability(Permissions permission) async {
    final status =
        await _channel.invokeMethod('checkAvailability', permission.index);
    return AvailabilityParser.statusFrom(status);
  }

  static Future<Status> request(Permissions permission) async {
    final status =
        await _channel.invokeMethod('requestPermission', permission.index);
    return StatusParser.statusFrom(status);
  }
}

enum Permissions {
  camera,
  microphone,
  contacts,
  calendar,
  location,
  locationWhenInUse,
  locationAlways,
  mediaLibrary,
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
  authorized,
  restrictedIOS,
  limitedIOS,
  permanentlyDeniedAndroid,
}

extension StatusParser on Status {
  static Status statusFrom(int value) {
    return [
      Status.denied,
      Status.authorized,
      Status.restrictedIOS,
      Status.limitedIOS,
      Status.permanentlyDeniedAndroid,
    ][value];
  }
}

enum Availability {
  enabled,
  disabled,
  nonApplicable,
}

extension AvailabilityParser on Availability {
  static Availability statusFrom(int value) {
    return [
      Availability.enabled,
      Availability.disabled,
      Availability.nonApplicable,
    ][value];
  }
}

class Permission {}
