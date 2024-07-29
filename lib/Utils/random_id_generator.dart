import 'dart:math';

String getRandomId(){
  final random = Random();
  const availableChars = '0123456789abcdef';
  final randomString = List.generate(5, (index) => availableChars[random.nextInt(availableChars.length)]).join();
  return '[#$randomString]';
}
