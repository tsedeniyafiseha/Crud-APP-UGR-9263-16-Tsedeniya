import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/custom_article_model.dart';
import '../bloc/custom_articles_bloc/custom_articles_bloc.dart';

class CreateArticleScreen extends StatefulWidget {
  final CustomArticleModel? articleToEdit;

  const CreateArticleScreen({Key? key, this.articleToEdit}) : super(key: key);

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late String _selectedCategory;

  final List<String> _categories = [
    'Technology', 'Sports', 'Business', 'Health', 'Entertainment', 'Science', 'Other'
  ];

  bool get _isEditing => widget.articleToEdit != null;

  @override
  void initState() {
    super.initState();
    final a = widget.articleToEdit;
    _titleController = TextEditingController(text: a?.title ?? '');
    _contentController = TextEditingController(text: a?.content ?? '');
    _selectedCategory = a?.category ?? 'Technology';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_isEditing) {
      final updated = widget.articleToEdit!.copyWith(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _selectedCategory,
        updatedAt: DateTime.now(),
      );
      context.read<CustomArticlesBloc>().add(UpdateCustomArticle(updated));
    } else {
      final article = CustomArticleModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _selectedCategory,
        createdAt: DateTime.now(),
      );
      context.read<CustomArticlesBloc>().add(CreateCustomArticle(article));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Article' : 'New Article'),
        actions: [
          TextButton(
            onPressed: _submit,
            child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title *', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Title is required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _selectedCategory = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content', border: OutlineInputBorder()),
              maxLines: 8,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Content is required' : null,
            ),
          ],
        ),
      ),
    );
  }
}
