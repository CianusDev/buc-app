import 'package:flutter/material.dart';
import 'package:tuto_flutter/core/constants/app_colors.dart';
import 'package:tuto_flutter/core/constants/app_sizes.dart';
import 'package:tuto_flutter/shared/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> notes = [
    {
      'id': '1',
      'title': 'Liste de courses',
      'content': 'Lait, œufs, pain, beurre, fruits et légumes.',
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
      'updatedAt': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'id': '2',
      'title': 'Idées de voyage',
      'content':
          'Visiter le Japon, découvrir les parcs nationaux aux USA, explorer l\'Islande.',
      'createdAt': DateTime.now().subtract(const Duration(days: 5)),
      'updatedAt': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '3',
      'title': 'Recette de gâteau au chocolat',
      'content':
          '200g de chocolat, 100g de beurre, 3 œufs, 50g de farine, 100g de sucre.',
      'createdAt': DateTime.now().subtract(const Duration(days: 10)),
      'updatedAt': DateTime.now().subtract(const Duration(days: 10)),
    },
    {
      'id': '4',
      'title': 'Objectifs 2024',
      'content':
          'Apprendre le piano, courir un marathon, lire 12 livres, voyager plus.',
      'createdAt': DateTime.now().subtract(const Duration(days: 15)),
      'updatedAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '5',
      'title': 'Réunion de travail',
      'content':
          'Discuter du nouveau design, revoir le budget, planifier le prochain sprint.',
      'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
      'updatedAt': DateTime.now().subtract(const Duration(hours: 5)),
    },
    {
      'id': '6',
      'title': 'Livres à lire',
      'content': '1984, Le Petit Prince, L\'Alchimiste, Sapiens.',
      'createdAt': DateTime.now().subtract(const Duration(days: 20)),
      'updatedAt': DateTime.now().subtract(const Duration(days: 20)),
    },
    {
      'id': '7',
      'title': 'Idées de projets',
      'content':
          'Créer une application de méditation, développer un blog de cuisine, lancer une chaîne YouTube.',
      'createdAt': DateTime.now().subtract(const Duration(days: 30)),
      'updatedAt': DateTime.now().subtract(const Duration(days: 25)),
    },
    {
      'id': '8',
      'title': 'Citations inspirantes',
      'content':
          '"Le succès n\'est pas la clé du bonheur. Le bonheur est la clé du succès." - Albert Schweitzer',
      'createdAt': DateTime.now().subtract(const Duration(days: 40)),
      'updatedAt': DateTime.now().subtract(const Duration(days: 40)),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSizes.small),
            child: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                // Handle more options action
              },
            ),
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: AppColors.secondary,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.normal,
                  ),
                  child: SearchBar(
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.only(
                        left: AppSizes.normal,
                        right: AppSizes.normal,
                      ),
                    ),
                    leading: const Icon(Icons.search),
                    hintText: 'Trouver une note',
                    elevation: WidgetStateProperty.all(0.0),
                    backgroundColor: WidgetStateProperty.all(
                      AppColors.background,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.normal,
                    vertical: AppSizes.small,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          overlayColor: AppColors.foreground.withValues(
                            alpha: 0.05,
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.north,
                          color: AppColors.foreground,
                        ),
                        label: const Text(
                          'Modifié récemment',
                          style: TextStyle(
                            fontSize: AppSizes.textDefault,
                            color: AppColors.foreground,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.grid_view,
                          color: AppColors.foreground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(
                left: AppSizes.normal,
                right: AppSizes.normal,
                top: AppSizes.small,
                bottom: AppSizes.large,
              ),
              itemCount: notes.length, // Replace with your actual item count
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSizes.normal),
              itemBuilder: (context, index) {
                return NoteItem(
                  id: notes[index]['id'],
                  title: notes[index]['title'],
                  content: notes[index]['content'],
                  createdAt: notes[index]['createdAt'],
                  updatedAt: notes[index]['updatedAt'],
                  onTap: () {
                    // Handle note tap
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add note action
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.background),
      ),
    );
  }
}
