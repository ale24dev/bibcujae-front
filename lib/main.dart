import 'package:flutter/material.dart';

import 'locator.dart';
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'src/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // drop the `#` in URLs on the web
  usePathUrlStrategy();
  
  setUp();

  runApp(const MyApp());
}
