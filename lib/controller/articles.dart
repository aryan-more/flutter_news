import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/articale.dart';
import 'package:news/utils/filters.dart' as filters;
import 'package:news/utils/url.dart';

abstract class BaseArticles {
  late Rx<Future<List<Article>>> articles;
  void reload() {}
}

class Headline extends GetxController implements BaseArticles {
  String apiEndpoint = headlineUrl("in", filters.category.first);

  RxString country = "in".obs;
  RxString category = filters.category.first.obs;

  void updateUrl() {
    apiEndpoint = headlineUrl(country.value, category.value);
    reload();
  }

  Headline() {
    articles = loadArticles(apiEndpoint).obs;
  }

  @override
  void reload() => articles.value = loadArticles(apiEndpoint);
  @override
  late Rx<Future<List<Article>>> articles;
}

class SearchController extends GetxController implements BaseArticles {
  late String apiEndpoint;

  String query;

  RxString sort = filters.sort.first.obs;

  void updateUrl() {
    apiEndpoint = search(query, sort.value);
    reload();
  }

  SearchController(this.query) {
    apiEndpoint = search(query, filters.category.first);
    articles = loadArticles(apiEndpoint).obs;
  }

  @override
  void reload() => articles.value = loadArticles(apiEndpoint);
  @override
  late Rx<Future<List<Article>>> articles;
}

Future<List<Article>> loadArticles(String apiEndpoint) async {
  try {
    http.Response response = await http.get(Uri.parse(apiEndpoint));

    Map body = jsonDecode(response.body);
    if (body["status"] == null || body["status"] != "ok") {
      throw Exception("Something went worng");
    }
    List<Article> articles = [];

    for (Map<String, dynamic> articleMap in body["articles"]) {
      articles.add(Article.fromJson(articleMap));
    }
    return articles;
  } catch (_) {
    rethrow;
  }
}
