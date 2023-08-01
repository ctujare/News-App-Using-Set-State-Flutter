import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/features/widgets/news_article.dart';
import 'package:news_app/models/article.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Article articles = Article(
    status: "",
    totalResults: 0,
    articles: [],
  );

  @override
  void initState() {
    _fetchArticles();
    super.initState();
  }

  void _fetchArticles() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=API_KEY_HERE");
    http.Response res = await http.get(url);

    if (res.statusCode == 200) {
      articles = Article.fromJson(jsonDecode(res.body));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Home Page"),
      ),
      body: (articles.totalResults! > 0)
          ? PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: articles.articles!.length,
              itemBuilder: (BuildContext context, int index) {
                Articles currentArticle = articles.articles![index];

                return NewsArticle(
                  description: currentArticle.description!,
                  imageUrl: currentArticle.urlToImage!,
                  newsUrl: currentArticle.url!,
                  title: currentArticle.title!,
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
