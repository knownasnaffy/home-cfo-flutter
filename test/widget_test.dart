import 'package:flutter_test/flutter_test.dart';
import 'package:home_cfo/main.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const HomeCFOApp());
      expect(find.text('Household Balance'), findsOneWidget);
    });
  });
}
