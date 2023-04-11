import 'package:flutter/material.dart';

import 'locator.dart';
import 'src/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUp();

  runApp(const MyApp());
}
