import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/controller/articles.dart';
import 'package:news/utils/filters.dart';
import 'package:news/utils/theme.dart';
import 'package:news/widgets/search.dart';
import 'package:news/widgets/tile/article.dart';

class HeadlineScreen extends StatelessWidget {
  const HeadlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).theme;
    final controller = Get.put(Headline());

    return Scaffold(
      appBar: AppBar(
        title: const SearchBar(
          query: null,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 40,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text("Category"),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => DropdownButton<String>(
                          value: controller.category.value,
                          // dropdownColor: theme.action,
                          focusColor: theme.accent,
                          items: category
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          onChanged: (x) {
                            if (x == null) return;

                            controller.category.value = x;
                            controller.updateUrl();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Country"),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => DropdownButton<String>(
                          value: controller.country.value,
                          // dropdownColor: theme.action,
                          focusColor: theme.accent,
                          items: availableCountries
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(code[e]!),
                                ),
                              )
                              .toList(),
                          onChanged: (x) {
                            if (x == null) return;

                            controller.country.value = x;
                            controller.updateUrl();
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Expanded(
            child: View(controller: controller, theme: theme),
          ),
        ],
      ),
    );
  }
}

class View extends StatelessWidget {
  const View({
    Key? key,
    required this.controller,
    required this.theme,
  }) : super(key: key);

  final BaseArticles controller;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FutureBuilder(
        future: controller.articles.value,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Something went wrong"),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(onPressed: controller.reload, child: const Text("Retry"))
                ],
              ),
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(color: theme.action),
            );
          }
          return ListView(
            children: snapshot.data!.map((e) => ArticleTile(article: e)).toList(),
          );
        },
      ),
    );
  }
}
