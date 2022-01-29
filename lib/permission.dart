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

  /// The notification permission with options: alert, badge, sound
  notification,

  /// The notification permission with any options
  notificationOptions,
  notificationOptionAlert,
  notificationOptionBadge,
  notificationOptionSound,
  notificationOptionCarPlay,

  /// To use Critical Alert permission the app should have
  /// a granted entitlement by Apple: com.apple.developer.usernotifications.critical-alerts
  notificationOptionCriticalAlert,
  notificationOptionProvisional,
  notificationOptionAnnouncement,
  notificationOptionTimeSensitive,
  appTrackingTransparencyIOS,

  calendar,
  reminderIOS,

  speech,

  locationAlways,
  locationWhenInUse,

  photos,
  photosWriteOnlyIOS,

  mediaLibrary,

  phoneAndroid,

  sensors,
  smsAndroid,
  storage,
  ignoreBatteryOptimizationsAndroid,
  mediaLocation,
  activityRecognitionAndroid,
  bluetooth,
  manageExternalStorageAndroid,
  systemAlertWindowAndroid,
  requestInstallPackageAndroid,
  accessNotificationPolicyAndroid,
  bluetoothScanAndroid,
  bluetoothAdvertiseAndroid,
  bluetoothConnectAndroid,
  unknown,
}

class PermissionOption {
  final int value;
  PermissionOption(this.value);

  static final notificationOptionAlert =
      PermissionOption(NotificationOption.alert.index);
  static final notificationOptionBadge =
      PermissionOption(NotificationOption.badge.index);
  static final notificationOptionSound =
      PermissionOption(NotificationOption.sound.index);
  static final notificationOptionCarPlay =
      PermissionOption(NotificationOption.carPlay.index);
  static final notificationOptionCriticalAlert =
      PermissionOption(NotificationOption.criticalAlert.index);
  static final notificationOptionAnnouncement =
      PermissionOption(NotificationOption.announcement.index);
  static final notificationOptionTimeSensitive =
      PermissionOption(NotificationOption.timeSensitive.index);
}

enum NotificationOption {
  alert,
  badge,
  sound,
  carPlay,
  criticalAlert,
  provisional,
  announcement,
  timeSensitive,
}

enum Status {
  denied,
  authorized,
  restrictedIOS,
  limitedIOS,
  permanentlyDeniedAndroid,
  notSupported, // In case of OS version does not supports permission
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
