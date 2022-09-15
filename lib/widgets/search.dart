import 'package:flutter/material.dart';
import 'package:news/screen/search/search.dart';
import 'package:news/utils/theme.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String? query;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController queryController;

  @override
  void initState() {
    queryController = TextEditingController(text: widget.query);
    super.initState();
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  void onSubmit() {}

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).theme;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(color: theme.textColor.withAlpha(25), borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: TextField(
          controller: queryController,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              SearchScreen.navigate(value);
            }
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: queryController.clear,
            ),
            hintText: 'Search Products',
          ),
        ),
      ),
    );
  }
}
