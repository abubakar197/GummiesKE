import 'package:flutter/material.dart';
import 'package:gummieske/screens/bottom_bar.dart';
import 'package:gummieske/screens/upload_products_form.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm()],
    );
  }
}
