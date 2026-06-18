import 'package:flutter/material.dart';
import 'package:buc/core/theme/app_theme.dart';
import 'package:buc/features/home/screen/home.dart';
import 'package:buc/features/note-detail/screen/note_detail.dart';

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
        '/': (context) => const HomeScreen(title: 'Buc'),
        '/note-detail': (context) => const NoteDetail(),
      },
    );
  }
}
