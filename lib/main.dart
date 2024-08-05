import 'package:cms_provider/service_provider/screens/login.dart';
import 'package:cms_provider/theme/theme.dart';
import 'package:cms_provider/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeNotifier(AppThemes.lightTheme),
        child: CmsProvider()
    ),
  );
}

class CmsProvider extends StatelessWidget {
  const CmsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CMS-Provider',
            theme: themeNotifier.themeData,
            // theme: ThemeData(
            //   primarySwatch: Colors.blue,
            //   textTheme: GoogleFonts.tajawalTextTheme(
            //     Theme.of(context).textTheme,
            //   ),
            // ),
            home: LoginScreen(),
          );
        }
    );
  }
}
