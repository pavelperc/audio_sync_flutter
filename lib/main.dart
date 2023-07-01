import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              children: _getListData(),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: Colors.green,
              child: const Text('hello'),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < text.length; i++) {
      widgets.add(Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        color: (i % 2 == 0) ? Colors.amber[600] : Colors.amber[500],
        child: Center(
          child: Text(
            text[i],
            style: GoogleFonts.lora(textStyle: TextStyle(fontSize: 20)),
          ),
        ),
      ));
    }
    return widgets;
  }
}
