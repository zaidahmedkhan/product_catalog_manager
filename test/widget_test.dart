import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:product_catalog_manager/main.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env');
  });

  testWidgets('App loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.byType(MyApp), findsOneWidget);
  });
}
