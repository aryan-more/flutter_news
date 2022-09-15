import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/controller/articles.dart';
import 'package:news/screen/headline/headline.dart';
import 'package:news/utils/filters.dart';
import 'package:news/utils/theme.dart';
import 'package:news/widgets/search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.query});
  final String query;

  static void navigate(String query) {
    Get.to(
      SearchScreen(
        query: query,
      ),
      preventDuplicates: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    SearchController controller = Get.isRegistered(tag: query) ? Get.find(tag: query) : Get.put(SearchController(query), tag: query);
    final AppTheme theme = Theme.of(context).theme;

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
              child: Row(
                children: [
                  const Text("Sort By"),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(
                    () => DropdownButton<String>(
                      value: controller.sort.value,
                      // dropdownColor: theme.action,
                      focusColor: theme.accent,
                      items: sort
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (x) {
                        if (x == null) return;

                        controller.sort.value = x;
                        controller.updateUrl();
                      },
                    ),
                  ),
                ],
              ),
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
