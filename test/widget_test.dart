import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neon_drift/core/services/audio_service.dart';
import 'package:neon_drift/core/services/storage_service.dart';
import 'package:neon_drift/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        return '.';
      },
    );
    await GetStorage.init();
    final storageService = StorageService();
    await storageService.init();
    Get.put<StorageService>(storageService, permanent: true);
    Get.put<AudioService>(AudioService(), permanent: true);
  });

  testWidgets('NeonDriftApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NeonDriftApp());
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(NeonDriftApp), findsOneWidget);
  });
}
