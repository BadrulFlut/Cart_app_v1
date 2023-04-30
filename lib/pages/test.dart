import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          // Content area
          Container(
            height: screenHeight,
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: Text('Main Content'),
            ),
          ),

          // Button container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  height: _isButtonVisible
                      ? 191
                      : _animationController.value * 191,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: _isButtonVisible
                      ? Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Button'),
                          ),
                        )
                      : SizedBox(),
                );
              },
            ),
          ),

          // Show button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isButtonVisible = !_isButtonVisible;
                  if (_isButtonVisible) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                });
              },
              child: Icon(_isButtonVisible ? Icons.close : Icons.arrow_upward),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
