import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/darck.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _CategoryList(),
            if (!newsService.isLoading)
              Expanded(
                  child: (newsService
                          .articlesByCategory[newsService.getSelectedCategory]!
                          .isEmpty)
                      ? const Center(
                          child: Text('News no available'),
                        )
                      : NewsList(newsService.arcticlesByCategosySelected!)),
            if (newsService.isLoading)
              const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    final NewsService newsService = Provider.of<NewsService>(context);

    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: newsService.categories.length,
        itemBuilder: ((BuildContext context, int index) {
          final cLabel = newsService.categories[index].label;
          return SizedBox(
            width: 109,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _IconButtom(category: newsService.categories[index]),
                  const SizedBox(height: 10),
                  Text('${cLabel[0].toUpperCase()}${cLabel.substring(1)}'),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _IconButtom extends StatelessWidget {
  final Category category;

  const _IconButtom({required this.category});

  @override
  Widget build(BuildContext context) {
    final newsService2 = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.label;
      },
      child: Container(
        width: 50,
        height: 50,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(category.icon,
            color: (newsService2.getSelectedCategory == category.label)
                ? darckTheme.indicatorColor
                : Colors.black54),
      ),
    );
  }
}
