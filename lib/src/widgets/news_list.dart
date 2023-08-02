import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_model.dart';
import 'package:news_app/src/theme/darck.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  const NewsList(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return _News(news: news[index], index: index);
      },
    );
  }
}

class _News extends StatelessWidget {
  final Article news;
  final int index;

  const _News({required this.news, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardTopBar(
          news: news,
          index: index,
        ),
        _CratTitle(
          news: news,
        ),
        _CardImage(news: news),
        _DescriptionCard(news: news),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const _cardButtoms(),
      ],
    );
  }
}

class _cardButtoms extends StatelessWidget {
  const _cardButtoms();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.star_border),
        ),
        const SizedBox(
          width: 20,
        ),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.more_horiz),
        )
      ],
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  final Article news;
  const _DescriptionCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text((news.description != null) ? news.description : ''),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article news;
  const _CardImage({required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (news.urlToImage != null)
              ? FadeInImage(
                  placeholder: const AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(news.urlToImage))
              : const Image(
                  image: AssetImage('assets/img/no-image.png'),
                ),
        ),
      ),
    );
  }
}

class _CratTitle extends StatelessWidget {
  final Article news;
  const _CratTitle({required this.news});

  @override
  Widget build(BuildContext context) {
    return Text(
      news.title!,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article news;
  final int index;
  const _CardTopBar({
    required this.news,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}.',
            style: TextStyle(color: darckTheme.indicatorColor),
          ),
          Text(
            (news.source!.name != null) ? '${news.source!.name}.' : "",
            style: TextStyle(color: darckTheme.indicatorColor),
          )
        ],
      ),
    );
  }
}
