import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';

import '../models/news_model.dart';
import 'package:http/http.dart' as http;

String _URL_NEWS = "https://newsapi.org/v2";
String _APIKEY = 'beb964d909d74f2fb8230b8e1da2ea46';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'scince'),
    Category(FontAwesomeIcons.futbol, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> articlesByCategory = {};

  NewsService() {
    getTopHeadLines();

    for (Category element in categories) {
      articlesByCategory[element.label] = [];
    }
  }

  get getSelectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  set selectedCategory(String value) {
    _selectedCategory = value;
    _isLoading = false;
    getNewsByCategory(value);
    notifyListeners();
  }

  List<Article>? get arcticlesByCategosySelected =>
      articlesByCategory[getSelectedCategory];

  getTopHeadLines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';

    final resp = await http.get(Uri.parse(url));
    final newsResponse =
        NewsResponse.fromJson(json.decode(utf8.decode(resp.bodyBytes)));

    headLines.addAll(newsResponse.articles!);
    notifyListeners();
  }

  List<Article>? get selectedArticlesByCategory =>
      articlesByCategory[getSelectedCategory];

  getNewsByCategory(String category) async {
    if (articlesByCategory[category]!.isEmpty) {
      final url =
          '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';

      final resp = await http.get(Uri.parse(url));
      final newsResponse =
          NewsResponse.fromJson(json.decode(utf8.decode(resp.bodyBytes)));

      articlesByCategory[category]
          ?.addAll(newsResponse.articles as Iterable<Article>);
    } else {
      return articlesByCategory[category];
    }

    notifyListeners();
  }
}
