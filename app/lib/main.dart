import 'package:app/routes/pages.dart';
import 'package:app/utils/routes.dart';
import 'package:design_system/source/themes/my_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: Routes.home,
      routes: Pages.pages,
      debugShowCheckedModeBanner: false,
      theme: Mytheme.myTheme,
    ),
  );
}
