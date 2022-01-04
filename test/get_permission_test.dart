import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_permission/get_permission.dart';

void main() {
  const MethodChannel channel = MethodChannel('get_permission');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
