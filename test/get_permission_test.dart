import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_permission/get_permission.dart';
import 'package:get_permission/permission.dart';

void main() {
  const MethodChannel channel = MethodChannel('get_permission');

  TestWidgetsFlutterBinding.ensureInitialized();

  test('Expect statuses', () {
    expect(StatusParser.statusFrom(0), Status.denied);
    expect(StatusParser.statusFrom(1), Status.authorized);
    expect(StatusParser.statusFrom(2), Status.restrictedIOS);
    expect(StatusParser.statusFrom(3), Status.limitedIOS);
    expect(StatusParser.statusFrom(4), Status.permanentlyDeniedAndroid);
    expect(StatusParser.statusFrom(5), Status.notSupported);
  });
}
