import 'dart:developer';
import 'dart:math';

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
  double _currentSliderValue = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    var percent = 100 * _controller.position.pixels / _controller.position.maxScrollExtent;
    // log("percent $percent");
    setState(() {
      _currentSliderValue = min(100, max(0, percent));
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
              controller: _controller,
              children: _getListData(),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                    activeColor: Colors.green[900],
                    inactiveColor: Colors.white,
                    value: _currentSliderValue,
                    max: 100,
                    onChanged: (double value) {
                      var offset = _controller.position.maxScrollExtent * value / 100;
                      _controller.jumpTo(offset);
                      // setState(() {
                      //   _currentSliderValue = value;
                      // });
                    },
                  ),
                  Text("${_currentSliderValue.round()} %")
                ],
              )
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
