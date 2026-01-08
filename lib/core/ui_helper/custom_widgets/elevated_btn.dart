import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class ElevatedBtn extends StatelessWidget {
  String btnName;
  VoidCallback onTap;
  Widget? widget;
  bool isWidget;
  double? width;
  Color bgColor ;
  Color fgColor ;

  ElevatedBtn({
    required this.btnName,
    required this.onTap,
    this.isWidget = false,
    this.widget,
    this.width = double.infinity,
    this.bgColor = Colors.white,
    this.fgColor = AppColors.mainAppColor

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: isWidget
            ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [widget!, SizedBox(width: 7), Text(btnName,style: TextStyle(fontWeight: FontWeight.bold),)])
            : Text(btnName,style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
