import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({super.key});
  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  @override
  Widget build(BuildContext context) {
    final note =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String title = note['title'] ?? '';
    String content = note['content'] ?? '';
    String date = note['createdAt'] != null
        ? (note['createdAt'] as DateTime).toLocal().toString()
        : 'Date inconnue';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier la note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Titre',
                border: InputBorder.none,
              ),
            ),
            Row(
              children: [
                Text(
                  'Date de création: $date',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            Expanded(
              child: TextFormField(
                initialValue: content,
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
