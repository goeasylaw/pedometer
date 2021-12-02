import 'package:flutter/material.dart';

class ExampleApp extends StatefulWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeroLaw',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        splashColor: Colors.white,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: _buildHome(context),
    );
  }

  Widget _buildHome(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

        ],
      )
    );
  }
}
