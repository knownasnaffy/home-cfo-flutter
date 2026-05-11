import 'package:flutter_test/flutter_test.dart';
import 'package:home_cfo/main.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const ProviderScope(child: HomeCFOApp()));

      // Give the providers some time to resolve and rebuild. pumpAndSettle can timeout if there are infinite animations, but we just need a few pumps.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Household Balance'), findsOneWidget);
    });
  });
}
