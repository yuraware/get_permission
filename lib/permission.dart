import 'dart:async';

abstract class PermissionHandler {
  static Future<Status> checkStatus(Permissions permission) async {
    throw UnimplementedError('Not implemented');
  }

  static Future<Availability> checkAvailability(Permissions permission) async {
    throw UnimplementedError('Not implemented');
  }

  static Future<Status> request(Permissions permission) async {
    throw UnimplementedError('Not implemented');
  }
}

enum Permissions {
  camera,
  microphone,
  contacts,
  notification,
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
