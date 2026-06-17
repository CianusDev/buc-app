import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  // Getter pour récupérer les notes depuis l'interface
  List<Note> get notes => _notes;

  // Méthode pour charger les notes sauvegardées
  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedNotes = prefs.getStringList('mes_notes');

    if (savedNotes != null) {
      _notes = savedNotes.map((noteJson) => Note.fromJson(noteJson)).toList();
      notifyListeners(); // Dit à l'interface de se mettre à jour !
    }
  }

  // Méthode pour ajouter une note et sauvegarder
  Future<void> addNote(Note note) async {
    _notes.add(note);
    await _saveNotesToPrefs();
    notifyListeners(); // Rafraîchit l'écran !
  }

  Future<void> updateNote(Note note) async {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
      await _saveNotesToPrefs();
      notifyListeners();
    }
  }

  // Méthode pour supprimer
  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    await _saveNotesToPrefs();
    notifyListeners();
  }

  // La fonction privée qui sauvegarde concrètement sur le téléphone
  Future<void> _saveNotesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> notesJson = _notes.map((note) => note.toJson()).toList();
    await prefs.setStringList('mes_notes', notesJson);
  }
}
