import 'package:flutter/material.dart';
import 'package:tuto_flutter/core/constants/app_colors.dart';
import 'package:tuto_flutter/core/constants/app_sizes.dart';

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NoteItem({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.list,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.normal),
      ),
      tileColor: AppColors.background,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.foreground,
        ),
      ),
      subtitle: Text(
        content,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: AppColors.foreground),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/note-detail',
          arguments: {
            'id': id,
            'title': title,
            'content': content,
            'createdAt': createdAt,
            'updatedAt': updatedAt,
          },
        );
      },
    );
  }
}
