import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

void showAboutScopesDialog(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  showAboutDialog(
    context: context,
    applicationIcon: Icon(
      Icons.adjust,
      size: 48,
    ),
    applicationName: packageInfo.appName,
    applicationVersion: packageInfo.version,
    applicationLegalese: '© ${DateTime.now().year} Ricardo Carvalho',
  );
}