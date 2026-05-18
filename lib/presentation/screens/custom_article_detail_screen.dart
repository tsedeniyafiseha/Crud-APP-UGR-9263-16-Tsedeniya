import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/models/custom_article_model.dart';
import '../bloc/custom_articles_bloc/custom_articles_bloc.dart';
import 'create_article_screen.dart';

class CustomArticleDetailScreen extends StatelessWidget {
  final CustomArticleModel article;

  const CustomArticleDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMMM dd, yyyy').format(article.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: Text(article.category),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreateArticleScreen(articleToEdit: article)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Delete Article'),
                  content: const Text('Are you sure you want to delete this article?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        context.read<CustomArticlesBloc>().add(DeleteCustomArticle(article.id));
                        Navigator.pop(context); // close dialog
                        Navigator.pop(context); // go back to list
                      },
                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(label: Text(article.category)),
                if (article.isImportant) ...[
                  const SizedBox(width: 8),
                  const Chip(
                    label: Text('Important'),
                    avatar: Icon(Icons.star, color: Colors.amber, size: 16),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Text(article.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.3)),
            const SizedBox(height: 8),
            if (article.author != null && article.author!.isNotEmpty) ...[
              Text('By ${article.author}', style: TextStyle(fontSize: 14, color: Colors.grey[600], fontStyle: FontStyle.italic)),
              const SizedBox(height: 4),
            ],
            Text(formattedDate, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            const Divider(height: 32),
            if (article.description != null && article.description!.isNotEmpty) ...[
              Text(article.description!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.5)),
              const SizedBox(height: 16),
            ],
            if (article.content != null && article.content!.isNotEmpty)
              Text(article.content!, style: TextStyle(fontSize: 15, height: 1.6, color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}
