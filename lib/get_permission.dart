library get_permission;

class GetPermission {
  Future<Status> get status => Future.delayed(Duration.zero, () async {
        return Status.granted;
      });
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
