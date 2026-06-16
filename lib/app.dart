import 'package:flutter/material.dart';
import 'package:tuto_flutter/core/theme/app_theme.dart';
import 'package:tuto_flutter/features/home/screen/home.dart';
import 'package:tuto_flutter/features/note-detail/screen/note_detail.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(title: 'Buc.'),
        '/note-detail': (context) => const NoteDetail(),
      },
    );
  }
}
