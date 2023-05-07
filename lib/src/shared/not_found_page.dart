import 'package:bibcujae/src/shared/extensions.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("Página no encontrada",
              style:
                  context.textTheme.bodyLarge?.copyWith(color: Colors.white))),
    );
  }
}
