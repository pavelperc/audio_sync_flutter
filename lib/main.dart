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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
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
  double _currentSliderValue = 0;
  bool _isVisible = true;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _isVisible = false;
    var percent = 100 * _controller.position.pixels / _controller.position.maxScrollExtent;
    // print("pixels ${_controller.position.pixels}, maxScrollExtent ${_controller.position.maxScrollExtent}");
    setState(() {
      _currentSliderValue = min(100, max(0, percent));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                ListView(
                  controller: _controller,
                  children: _getListData(),
                ),
                IgnorePointer(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            0,
                            0.45,
                            0.55,
                            1
                          ],
                          colors: [
                            Colors.black,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black
                          ]),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                  child: Visibility(
                    visible: _isVisible,
                    child: Container(
                      color: Colors.black,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(32),
                      child: ClipRRect(
                        child: Image.asset('assets/images/cover.jpg'),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Slider(
                      activeColor: Colors.orange,
                      thumbColor: Colors.white,
                      inactiveColor: Colors.white24,
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
                  ],
                )),
          ),
        ],
      ),
    );
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    // widgets.add(Container(height: 200));
    // for (int i = 0; i < text.length; i++) {
    //   widgets.add(Container(
    //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    //     color: Colors.black,
    //     child: Center(
    //       child: Text(
    //         text[i],
    //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
    //       ),
    //     ),
    //   ));
    // }
    // var allText = "\n\n\n\n\n" + text.join("\n\n") + "\n\n\n\n\n";
    var allText = "\n\n\n\n\n\n\n\n" + text + "\n\n\n\n\n";
    widgets.add(Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Colors.black,
      child: Center(
        child: Text(
          allText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    ));
    // widgets.add(Container(height: 200));
    return widgets;
  }
}
