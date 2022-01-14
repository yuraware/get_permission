import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_permission/permission.dart';

class _GetPermission extends PermissionHandler {
  static const MethodChannel _channel = MethodChannel('get_permission');

  static Future<Status> checkStatus(
      Permissions permission, List<int>? additional) async {
    List<int> params = [permission.index];
    if (additional != null) {
      params.addAll(additional);
    }
    final status = await _channel.invokeMethod('checkPermission', params);
    return StatusParser.statusFrom(status);
  }

  static Future<Availability> checkAvailability(Permissions permission) async {
    final status =
        await _channel.invokeMethod('checkAvailability', permission.index);
    return AvailabilityParser.statusFrom(status);
  }

  static Future<Status> request(
      Permissions permission, List<int>? additional) async {
    List<int> params = [permission.index];
    if (additional != null) {
      params.addAll(additional);
    }
    final status = await _channel.invokeMethod('requestPermission', params);
    return StatusParser.statusFrom(status);
  }

  static Future<Map<Permissions, Status>> requestPermissions(
      List<Permissions> permissions) async {
    final permissionIndices = permissions.map((p) => p.index).toList();
    final statuses =
        await _channel.invokeMethod('requestPermissions', permissionIndices);

    return Map<int, int>.from(statuses).map((key, val) {
      return MapEntry<Permissions, Status>(
          Permissions.values[key], StatusParser.statusFrom(val));
    });
  }

  static Future<Map<Permissions, Status>> checkStatuses(
      List<Permissions> permissions) async {
    final permissionIndices = permissions.map((p) => p.index).toList();
    final statuses =
        await _channel.invokeMethod('checkPermissions', permissionIndices);

    return Map<int, int>.from(statuses).map((key, val) {
      return MapEntry<Permissions, Status>(
          Permissions.values[key], StatusParser.statusFrom(val));
    });
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
      Status.notSupported
    ][value];
  }
}

extension GetPermissionHandler on Permissions {
  /// Check permission status
  ///
  Future<Status> checkStatus() async {
    return _GetPermission.checkStatus(this, null);
  }

  /// Check permission status with multiple options
  ///
  Future<Status> checkStatusWithOptions(
      Permissions permission, List<PermissionOption>? options) async {
    if (permission != Permissions.notificationOptions) {
      throw ArgumentError(
          'Check status of permission with multiple options is only available for Permissions.notificationOptions');
    }
    final permissionOptions = options?.map((option) => option.value).toList();
    return _GetPermission.checkStatus(permission, permissionOptions);
  }

  /// Check permission availability on the platform
  ///
  Future<Availability> checkAvailability() async {
    return _GetPermission.checkAvailability(this);
  }

  /// Request a permission
  ///
  Future<Status> request() async {
    return _GetPermission.request(this, null);
  }

  /// Request a permission with multiple options
  ///
  Future<Status> requestWithOptions(List<PermissionOption>? options) async {
    if (this != Permissions.notificationOptions) {
      throw ArgumentError(
          'Request permission with multiple options is only available for Permissions.notificationOptions');
    }
    final permissionOptions = options?.map((option) => option.value).toList();
    return _GetPermission.request(this, permissionOptions);
  }
}

extension GetPermissionsHandler on List<Permissions> {
  /// Request multiple permissions
  ///
  Future<Map<Permissions, Status>> request() async {
    return _GetPermission.requestPermissions(this);
  }

  /// Check status of multiple permissions
  ///
  Future<Map<Permissions, Status>> checkStatuses() async {
    return _GetPermission.checkStatuses(this);
  }
}
