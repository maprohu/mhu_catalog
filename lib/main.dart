import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhu_catalog/app_info.dart';
import 'package:mhu_dart_commons/commons.dart';
import 'package:mhu_flutter_commons/mhu_flutter_commons.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'apps.dart';

void main() {
  runApp(const MhuCatalogApp());
}

final _appInfos = App.values.map(appInfo.entry).whereNotNull();

const buttonWidth = 200.0;
const padding = 8.0;
final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return ScaffoldParts(
        title: const Text('MHU Catalog'),
        body: GridView.extent(
          maxCrossAxisExtent: 200,
          children: _appInfos.map((entry) {
            final MapEntry(
              key: app,
              value: info,
            ) = entry;
            return InkWell(
              onTap: () {
                context.go('/${app.name}');
              },
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        'assets/icons/${app.iconSvgFileName}',
                      ),
                    ),
                    Text(
                      info.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ).withPadding(8),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ).scaffold;
    },
    routes: _appInfos.map((entry) {
      final MapEntry(
        key: app,
        value: info,
      ) = entry;
      return GoRoute(
        path: app.name,
        builder: (context, state) {
          return ScaffoldParts(
            title: Text(info.title),
            body: SafeScrollColumn(
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/${app.iconSvgFileName}',
                    width: 100,
                  ),
                ).withPadding(8),
                Text(
                  info.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ...info.appleStore.nullableAsIterable.map((appleStore) {
                  return Padding(
                    padding: const EdgeInsets.all(padding),
                    child: InkWell(
                      child: SvgPicture.asset(
                        'assets/images/apple-store-badge.svg',
                        width: buttonWidth,
                      ),
                      onTap: () {
                        launchUrlString(appleStore);
                      },
                    ),
                  );
                }),
                ...info.googlePlay.nullableAsIterable.map((googlePlay) {
                  return Padding(
                    padding: const EdgeInsets.all(padding),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: buttonWidth,
                      ),
                      child: InkWell(
                        child: Image.asset(
                          'assets/images/google-play-badge.png',
                        ),
                        onTap: () {
                          launchUrlString(googlePlay);
                        },
                      ),
                    ),
                  );
                }),
                ...info.webLink.nullableAsIterable.map((webLink) {
                  return Padding(
                    padding: const EdgeInsets.all(padding),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: buttonWidth,
                      ),
                      child: OutlinedButton.icon(
                        icon: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.open_in_browser,
                            size: 40,
                            color: Colors.black,
                          ),
                        ),
                        label: const Text("Open in Browser"),
                        onPressed: () {
                          launchUrlString(webLink);
                        },
                      ),
                    ),
                  );
                }),
                ...info.googleInternalTesting.nullableAsIterable
                    .map((googleTesting) {
                  return Padding(
                    padding: const EdgeInsets.all(padding),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: buttonWidth,
                      ),
                      child: OutlinedButton.icon(
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "assets/images/google-play-icon.svg",
                            width: 32,
                          ),
                        ),
                        label: const Text("Google Play Internal Testing"),
                        onPressed: () {
                          launchUrlString(googleTesting);
                        },
                      ),
                    ),
                  );
                }),
                ...info.github.nullableAsIterable.map((github) {
                  return Padding(
                    padding: const EdgeInsets.all(padding),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: buttonWidth,
                      ),
                      child: OutlinedButton.icon(
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "assets/images/github-mark.svg",
                            width: 32,
                          ),
                        ),
                        label: const Text("Source Code"),
                        onPressed: () {
                          launchUrlString(github);
                        },
                      ),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: futureBuilder(
                      future: rootBundle.loadString(
                        'assets/descriptions/${app.packageName}.md',
                      ),
                      builder: (context, markdownString) {
                        return MarkdownBody(
                          data: markdownString,
                          onTapLink: (text, href, title) {
                            if (href == null) {
                              return;
                            }
                            launchUrlString(href);
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text("More Apps"),
                  ),
                ),
              ],
            ),
          ).scaffold;
        },
      );
    }).toList(),
  ),
]);

class MhuCatalogApp extends StatelessWidget {
  const MhuCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MHU Catalog',
      routerConfig: _router,
    );
  }
}
