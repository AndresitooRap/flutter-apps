import 'package:appsena_frontend/models/news.dart';
import 'package:appsena_frontend/widgets/news_item.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              const Text(
                "Novedades",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              ...List.generate(
                news.length,
                (index) => NewItem(news: news[index],),
              )
            ],
          ),
        ),
      ),
    );
  }
}
