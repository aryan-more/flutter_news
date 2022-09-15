import 'package:flutter/material.dart';
import 'package:news/models/articale.dart';
import 'package:news/utils/theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).theme;

    return GestureDetector(
      onTap: () {
        launchUrlString(article.url);
      },
      child: Container(
        height: article.urlToImage == null ? null : 110,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.background,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: theme.accent.withAlpha(150),
              spreadRadius: 1,
              blurRadius: 1.25,
            ),
          ],
        ),
        child: Row(
          children: [
            if (article.urlToImage != null)
              Image.network(
                article.urlToImage!,
                height: 90,
                width: 150,
                fit: BoxFit.scaleDown,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(height: 90, width: 150, child: Text("Unable to load image"));
                },
              ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.title != null)
                    Text(
                      article.title!,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (article.description != null)
                    Text(
                      article.description!,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (article.author != null)
                    Text(
                      article.author!,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (article.publishedAt != null)
                    Text(
                      'Published at ${article.publishedAt!.split("T").first}',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
