import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuto_flutter/providers/note_provider.dart';
import 'app.dart';

void main() {
  runApp(
    // On enveloppe l'app avec ChangeNotifierProvider
    ChangeNotifierProvider(
      // On crée le provider et on appelle immédiatement loadNotes() avec ".."
      create: (context) => NoteProvider()..loadNotes(),
      child: const MyApp(),
    ),
  );
}
