import 'dart:math';
import 'package:coffe_app_animations/constants/names.dart';

double _doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start);

final random = Random();

final coffees = List.generate(
  names.length,
  (index) => Coffee(
      name: names[index],
      image: 'images/coffee/${index + 1}.png',
      price: _doubleInRange(random, 3, 7)),
);

class Coffee {
  final String name;
  final String image;
  final double price;

  Coffee({required this.name, required this.image, required this.price});
}
