// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

NewsResponse newsResponseFromJson(String str) =>
    NewsResponse.fromJson(json.decode(str));

String newsResponseToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  NewsResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  NewsResponse copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) =>
      NewsResponse(
        status: status ?? this.status,
        totalResults: totalResults ?? this.totalResults,
        articles: articles ?? this.articles,
      );

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}

class Article {
  final Source? source;
  final String? author;
  final String? title;
  final dynamic description;
  final String? url;
  final dynamic urlToImage;
  final DateTime? publishedAt;
  final dynamic content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Article copyWith({
    Source? source,
    String? author,
    String? title,
    dynamic description,
    String? url,
    dynamic urlToImage,
    DateTime? publishedAt,
    dynamic content,
  }) =>
      Article(
        source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source!.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
      };
}

class Source {
  final Id? id;
  final Name? name;

  Source({
    this.id,
    this.name,
  });

  Source copyWith({
    Id? id,
    Name? name,
  }) =>
      Source(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: idValues.map[json["id"]],
        name: nameValues.map[json["name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "name": nameValues.reverse[name],
      };
}

enum Id { GOOGLE_NEWS }

final idValues = EnumValues({"google-news": Id.GOOGLE_NEWS});

enum Name { GOOGLE_NEWS }

final nameValues = EnumValues({"Google News": Name.GOOGLE_NEWS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
