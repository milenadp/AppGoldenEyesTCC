import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserRepository(),
      child: AppWidget(),
    ),
  );
}
