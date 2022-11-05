import 'dart:math';

class ImageHandler {
  getRandomImage() {
    List<String> strArr = ['rose.jpg', 'd4.jpg', 'd5.jpg', 'd6.jpg', 'd7.jpg'];

// generates a new Random object
    final _random = Random();

// generate a random index based on the list length
// and use it to retrieve the element
    var element = strArr[_random.nextInt(strArr.length)];

    return element;
  }
}
