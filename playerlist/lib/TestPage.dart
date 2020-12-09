import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playerlist/TestItem.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  PageController _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        allowImplicitScrolling: true,
        pageSnapping: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 20,
        itemBuilder: (context,i) {
          return TestItem(index: "当前页$i",);
        },
      ),
    );
  }
}