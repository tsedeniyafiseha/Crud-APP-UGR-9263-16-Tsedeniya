import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/custom_articles_bloc/custom_articles_bloc.dart';
import 'create_article_screen.dart';
import 'custom_article_detail_screen.dart';

class MyArticlesScreen extends StatefulWidget {
  const MyArticlesScreen({Key? key}) : super(key: key);

  @override
  State<MyArticlesScreen> createState() => _MyArticlesScreenState();
}

class _MyArticlesScreenState extends State<MyArticlesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomArticlesBloc>().add(LoadCustomArticles());
  }

  void _deleteArticle(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Article'),
        content: const Text('Are you sure you want to delete this article?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<CustomArticlesBloc>().add(DeleteCustomArticle(id));
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Articles'),
      ),
      body: BlocConsumer<CustomArticlesBloc, CustomArticlesState>(
        listener: (context, state) {
          if (state is CustomArticleOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CustomArticlesLoaded) {
            if (state.articles.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.article_outlined, size: 80, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Text('No articles yet', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    Text('Tap + to create your first article', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Text(article.category[0], style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    title: Text(article.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(article.category),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (article.isImportant)
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CreateArticleScreen(articleToEdit: article),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                          onPressed: () => _deleteArticle(context, article.id),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomArticleDetailScreen(article: article),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (state is CustomArticlesError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateArticleScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
