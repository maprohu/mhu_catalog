import 'dart:io';

import 'package:mhu_catalog/apps.dart';
import 'package:mhu_dart_commons/io.dart';
import 'package:recase/recase.dart';

Future<void> main() async {
  final cwd = Directory.current;
  final assetsDir = cwd.dir('assets');
  final iconsDir = assetsDir.dir('icons');
  final descriptionsDir = assetsDir.dir('descriptions');
  final rootDir = cwd.parent;

  for (final app in App.values) {
    final name = app.name.snakeCase;
    final appDir = rootDir.dir(name);

    final appAssetsDir = appDir.dir('assets');

    final icon = appAssetsDir.file('icon.svg');
    final description = appAssetsDir.file('description.md');

    Future<void> copy(
        File sourceFile, Directory targetDir, String targetFileName) async {
      final targetFile = targetDir.file(targetFileName);
      stdout.writeln("Writing: ${targetFile.uri}");
      await sourceFile.copy(targetFile.path);
    }

    await copy(icon, iconsDir, '$name.svg');
    await copy(description, descriptionsDir, '$name.md');
  }
}
