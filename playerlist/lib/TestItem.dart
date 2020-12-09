import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestItem extends StatefulWidget {

  TestItem({Key key, this.index}):super(key: key);

  final String index;

  @override
  _TestItemState createState() => _TestItemState();

}

class _TestItemState extends State<TestItem> {
  @override
  void initState() {
    print("测试预加载${widget.index}");
    super.initState();
  }

  @override
  void dispose() {
    print("测试销毁${widget.index}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Center(
              child: Text(
                widget.index,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}