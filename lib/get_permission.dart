library get_permission;

class GetPermission {}

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

  restrictedIOS,
  limitedIOS,
  permanentlyDeniedAndroid,
}

class Permission {}
