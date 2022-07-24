import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lz4_flutter/lz4_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('lz4_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Lz4Flutter.platformVersion, '42');
  });
}
