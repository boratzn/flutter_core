import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  void push(Widget page) =>
      Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  void pop() => Navigator.pop(this);

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}
