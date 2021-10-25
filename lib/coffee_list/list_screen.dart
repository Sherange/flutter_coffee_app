import 'package:coffe_app_animations/constants/app_const.dart';
import 'package:coffe_app_animations/models/coffee.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _pageCoffeController =
      PageController(viewportFraction: 0.45, initialPage: initialPage.toInt());

  final _pageTextController = PageController(initialPage: initialPage.toInt());

  double _currentPage = initialPage;
  double _textPage = initialPage;

  void _coffeeScrollListner() {
    setState(() {
      _currentPage = _pageCoffeController.page!;
    });
  }

  void _textScrollListner() {
    _textPage = _currentPage;
  }

  @override
  void initState() {
    _pageCoffeController.addListener(_coffeeScrollListner);
    _pageTextController.addListener(_textScrollListner);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeController.removeListener(_coffeeScrollListner);
    _pageTextController.removeListener(_textScrollListner);
    _pageCoffeController.dispose();
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
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
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: _pageCoffeController,
                scrollDirection: Axis.vertical,
                itemCount: coffees.length,
                onPageChanged: (value) {
                  if (value < coffees.length) {
                    _pageTextController.animateToPage(
                      value,
                      duration: duration,
                      curve: Curves.easeOut,
                    );
                  }
                },
                itemBuilder: (context, index) {
                  // if (index == 0) {
                  //   return SizedBox.shrink();
                  // }
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
                        child: Hero(
                          tag: coffee.name,
                          child: Image.asset(
                            coffee.image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 100,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      itemCount: coffees.length,
                      controller: _pageTextController,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final opacity =
                            (1 - (index - _textPage).abs()).clamp(0.0, 1.0);
                        return Opacity(
                            opacity: opacity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                coffees[index].name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w800),
                              ),
                            ));
                      }),
                ),
                SizedBox(height: 15),
                AnimatedSwitcher(
                  duration: duration,
                  child: Text(
                    '\$${coffees[_currentPage.toInt()].price}',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    key: Key(coffees[_currentPage.toInt()].name),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
