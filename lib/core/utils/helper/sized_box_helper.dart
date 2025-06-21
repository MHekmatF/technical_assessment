import 'package:flutter/material.dart';
import 'package:technical_assessment/core/utils/helper/extention.dart';

SizedBox responsiveHeight(BuildContext context , double height) {
  return SizedBox(
    height:context.height * height,
  );
}
SizedBox sizedBoxWidth(BuildContext context , double width) {
  return SizedBox(
    width: context.width * width,
  );
}