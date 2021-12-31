import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_permission/permission.dart';

class GetPermission extends PermissionHandler {
  static const MethodChannel _channel = MethodChannel('get_permission');

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

extension GetPermissionHandler on Permissions {
  Future<Status> checkStatus(Permissions permission) async {
    return GetPermission.checkStatus(permission);
  }

  Future<Availability> checkAvailability(Permissions permission) async {
    return GetPermission.checkAvailability(permission);
  }

  Future<Status> request(Permissions permission) async {
    return GetPermission.request(permission);
  }
}
