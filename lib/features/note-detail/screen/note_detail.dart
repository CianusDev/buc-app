import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuto_flutter/models/note.dart';
import 'package:tuto_flutter/providers/note_provider.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({super.key});
  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final bool _isNew;
  late final String? _existingId;
  late final DateTime? _existingCreatedAt;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _isNew = args == null;
    _existingId = args?['id'] as String?;
    _existingCreatedAt = args?['createdAt'] as DateTime?;
    _titleController = TextEditingController(text: args?['title'] ?? '');
    _contentController = TextEditingController(text: args?['content'] ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final now = DateTime.now();
    final note = Note(
      id: _isNew
          ? now.millisecondsSinceEpoch.toString()
          : _existingId!,
      title: title,
      content: content,
      createdAt: _isNew ? now : _existingCreatedAt!,
      updatedAt: now,
    );

    final provider = context.read<NoteProvider>();
    if (_isNew) {
      provider.addNote(note);
    } else {
      provider.updateNote(note);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final date = _existingCreatedAt != null
        ? _existingCreatedAt.toLocal().toString().substring(0, 16)
        : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'Nouvelle note' : 'Modifier la note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              maxLines: null,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Titre',
                border: InputBorder.none,
              ),
            ),
            if (date.isNotEmpty)
              Row(
                children: [
                  Text(
                    'Créé le $date',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            Expanded(
              child: TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Écrivez votre note ici...',
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
