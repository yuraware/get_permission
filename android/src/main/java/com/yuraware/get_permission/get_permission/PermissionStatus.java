package com.yuraware.get_permission.get_permission;

public class PermissionStatus {


}

final class PermissionGroup {
    static final int PermissionGroupCamera_camera = 0;
    static final int PermissionGroupCamera_microphone = 1;
    static final int PermissionGroupCamera_contacts = 2;

    /// The notification permission with options: alert, badge, sound
    static final int notification;

    /// The notification permission with any options
    static final int notificationOptions;
    static final int notificationOptionAlert;
    static final int notificationOptionBadge;
    static final int notificationOptionSound;
    static final int notificationOptionCarPlay;

    /// To use Critical Alert permission the app should have
    /// a granted entitlement by Apple: com.apple.developer.usernotifications.critical-alerts
    static final int notificationOptionCriticalAlert;
    static final int notificationOptionProvisional;
    static final int notificationOptionAnnouncement;
    static final int notificationOptionTimeSensitive;
    static final int appTrackingTransparencyIOS;

    static final int calendar;
    static final int reminderIOS;

    static final int speech;

    static final int locationAlways;
    static final int locationWhenInUse;

    static final int photos;
    static final int photosWriteOnlyIOS;

    static final int mediaLibrary;

    static final int phone;

    static final int sensors;

    static final int smsAndroid;
    static final int storage;
    static final int ignoreBatteryOptimizationsAndroid;
    static final int mediaLocation;
    static final int activityRecognitionAndroid;
    static final int bluetooth;
    static final int manageExternalStorageAndroid;
    static final int systemAlertWindowAndroid;
    static final int requestInstallPackageAndroid;
    static final int accessNotificationPolicyAndroid;
    static final int bluetoothScanAndroid;
    static final int bluetoothAdvertiseAndroid;
    static final int bluetoothConnectAndroid;
    static final int unknown;
}



/*
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

  phone,

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
 */
