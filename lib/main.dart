import 'package:flutter/material.dart';
import 'package:notes/data/DBHelper.dart';
import 'package:notes/db_provider.dart';
import 'package:notes/homePage.dart';
import 'package:notes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DbProvider(dbhelper: Dbhelper.getInstance),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode:
              themeProvider.getThemeValue() ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Joseph',
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontWeight: FontWeight.w400),
              bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              titleLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: Brightness.dark,
            ),
          ),
          theme: ThemeData(
            fontFamily: 'Joseph',
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontWeight: FontWeight.w400),
              bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              titleLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          ),
          home: Homepage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Center(child: Text("Notes", textAlign: TextAlign.center)),
      ),
      body: Column(children: [Text("hello")]),
    );
  }
}
