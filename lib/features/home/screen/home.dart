import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buc/core/constants/app_colors.dart';
import 'package:buc/core/constants/app_sizes.dart';
import 'package:buc/providers/note_provider.dart';
import 'package:buc/shared/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  bool isGridView = false;
  bool _sortAscending = false;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  // final List<Map<String, dynamic>> notes = [
  //   {
  //     'id': '1',
  //     'title': 'Liste de courses',
  //     'content': 'Lait, œufs, pain, beurre, fruits et légumes.',
  //     'createdAt': DateTime.now().subtract(const Duration(days: 1)),
  //     'updatedAt': DateTime.now().subtract(const Duration(hours: 2)),
  //   },
  //   {
  //     'id': '2',
  //     'title': 'Idées de voyage',
  //     'content':
  //         'Visiter le Japon, découvrir les parcs nationaux aux USA, explorer l\'Islande.',
  //     'createdAt': DateTime.now().subtract(const Duration(days: 5)),
  //     'updatedAt': DateTime.now().subtract(const Duration(days: 2)),
  //   },
  //   {
  //     'id': '3',
  //     'title': 'Recette de gâteau au chocolat',
  //     'content':
  //         '200g de chocolat, 100g de beurre, 3 œufs, 50g de farine, 100g de sucre.',
  //     'createdAt': DateTime.now().subtract(const Duration(days: 10)),
  //     'updatedAt': DateTime.now().subtract(const Duration(days: 10)),
  //   },
  //   {
  //     'id': '4',
  //     'title': 'Objectifs 2024',
  //     'content':
  //         'Apprendre le piano, courir un marathon, lire 12 livres, voyager plus.',
  //     'createdAt': DateTime.now().subtract(const Duration(days: 15)),
  //     'updatedAt': DateTime.now().subtract(const Duration(days: 1)),
  //   },
  //   {
  //     'id': '5',
  //     'title': 'Réunion de travail',
  //     'content':
  //         'Discuter du nouveau design, revoir le budget, planifier le prochain sprint.',
  //     'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
  //     'updatedAt': DateTime.now().subtract(const Duration(hours: 5)),
  //   },
  //   {
  //     'id': '6',
  //     'title': 'Livres à lire',
  //     'content': '1984, Le Petit Prince, L\'Alchimiste, Sapiens.',
  //     'createdAt': DateTime.now().subtract(const Duration(days: 20)),
  //     'updatedAt': DateTime.now().subtract(const Duration(days: 20)),
  //   },
  //   {
  //     'id': '7',
  //     'title': 'Idées de projets',
  //     'content':
  //         'Créer une application de méditation, développer un blog de cuisine, lancer une chaîne YouTube.',
  //     'createdAt': DateTime.now().subtract(const Duration(days: 30)),
  //     'updatedAt': DateTime.now().subtract(const Duration(days: 25)),
  //   },
  //   {
  //     'id': '8',
  //     'title': 'Citations inspirantes',
  //     'content':
  //         '"Le succès n\'est pas la clé du bonheur. Le bonheur est la clé du succès." - Albert Schweitzer',
  //     'createdAt': DateTime.now().subtract(const Duration(days: 40)),
  //     'updatedAt': DateTime.now().subtract(const Duration(days: 40)),
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    // context.watch() "écoute" le provider.
    // Si une note est ajoutée, le widget va se reconstruire tout seul !
    final noteProvider = context.watch<NoteProvider>();
    final notes = noteProvider.notes;
    final filteredNotes =
        notes.where((note) {
          final title = note.title.toString().toLowerCase();
          final content = note.content.toString().toLowerCase();
          final query = _searchQuery.toLowerCase();
          return title.contains(query) || content.contains(query);
        }).toList()..sort(
          (a, b) => _sortAscending
              ? a.updatedAt.compareTo(b.updatedAt)
              : b.updatedAt.compareTo(a.updatedAt),
        );

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
                    focusNode: _searchFocusNode, // connecte le node au widge
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    onTapOutside: (_) =>
                        _searchFocusNode.unfocus(), // tap dehors → perd focus
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
                        onPressed: () {
                          setState(() => _sortAscending = !_sortAscending);
                        },
                        icon: Icon(
                          _sortAscending ? Icons.south : Icons.north,
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
                        onPressed: () {
                          setState(() {
                            isGridView = !isGridView; // Toggle the view state
                          });
                        },
                        icon: Icon(
                          isGridView ? Icons.list : Icons.grid_view,
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
            child: filteredNotes.isEmpty
                ? const Center(child: Text("Aucune note pour le moment."))
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    layoutBuilder: (currentChild, previousChildren) =>
                        currentChild ?? const SizedBox.shrink(),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0, 0.04),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              ),
                            ),
                        child: child,
                      ),
                    ),
                    child: KeyedSubtree(
                      key: ValueKey(_sortAscending),
                      child: isGridView
                          ? GridView.builder(
                              padding: const EdgeInsets.only(
                                left: AppSizes.normal,
                                right: AppSizes.normal,
                                top: AppSizes.small,
                                bottom: AppSizes.large,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: AppSizes.normal,
                                    mainAxisSpacing: AppSizes.normal,
                                    childAspectRatio: 1.0,
                                  ),
                              itemCount: filteredNotes.length,
                              itemBuilder: (context, index) {
                                final note = filteredNotes[index];
                                return GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        backgroundColor: AppColors.background,
                                        title: const Text(
                                          'Supprimer la note ?',
                                        ),
                                        content: Text(
                                          '"${note.title}" sera supprimée définitivement.',
                                        ),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.foreground,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Annuler'),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.destructive,
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<NoteProvider>()
                                                  .deleteNote(note.id);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Supprimer',
                                              style: TextStyle(
                                                color: AppColors.destructive,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: NoteItem(
                                    id: note.id,
                                    title: note.title,
                                    content: note.content,
                                    createdAt: note.createdAt,
                                    updatedAt: note.updatedAt,
                                  ),
                                );
                              },
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(
                                left: AppSizes.normal,
                                right: AppSizes.normal,
                                top: AppSizes.small,
                                bottom: AppSizes.large,
                              ),
                              itemCount: filteredNotes.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: AppSizes.normal),
                              itemBuilder: (context, index) {
                                final note = filteredNotes[index];
                                return Dismissible(
                                  key: Key(note.id),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (_) async {
                                    return await showDialog<bool>(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        backgroundColor: AppColors.background,
                                        title: const Text(
                                          'Supprimer la note ?',
                                        ),
                                        content: Text(
                                          '"${note.title}" sera supprimée définitivement.',
                                        ),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.foreground,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Annuler'),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.destructive,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text(
                                              'Supprimer',
                                              style: TextStyle(
                                                color: AppColors.destructive,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onDismissed: (_) {
                                    context.read<NoteProvider>().deleteNote(
                                      note.id,
                                    );
                                  },
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(
                                      right: AppSizes.normal,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.destructive,
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.normal,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: NoteItem(
                                    id: note.id,
                                    title: note.title,
                                    content: note.content,
                                    createdAt: note.createdAt,
                                    updatedAt: note.updatedAt,
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/note-detail');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.background),
      ),
    );
  }
}
