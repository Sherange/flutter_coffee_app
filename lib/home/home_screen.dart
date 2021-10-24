import 'package:coffe_app_animations/models/coffee.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageCoffeController = PageController(viewportFraction: 0.45);
  double _currentPage = 0.0;

  void _coffeeScrollListner() {
    setState(() {
      _currentPage = _pageCoffeController.page!;
    });
  }

  @override
  void initState() {
    _pageCoffeController.addListener(_coffeeScrollListner);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeController.removeListener(_coffeeScrollListner);
    _pageCoffeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: -size.height * 0.2,
            height: size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset.zero,
                      color: Colors.brown,
                      blurRadius: 80,
                      spreadRadius: 45)
                ],
              ),
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: 0,
          //   height: 100,
          //   child: Container(
          //     color: Colors.red,
          //   ),
          // ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: _pageCoffeController,
                scrollDirection: Axis.vertical,
                itemCount: coffees.length,
                itemBuilder: (context, index) {
                  final coffee = coffees[index];
                  final result = _currentPage - index + 1;

                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..translate(0.0, size.height / 2.6 * (1 - value).abs())
                        ..setEntry(3, 2, 0.001)
                        ..scale(value),
                      child: Opacity(
                        opacity: opacity,
                        child: Image.asset(
                          coffee.image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
