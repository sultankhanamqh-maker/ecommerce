import 'package:flutter/material.dart';

InputDecoration textFieldDecor({required String hint,required String label,bool isIcon= false, VoidCallback? onTap,bool isVisible = false}){
  return InputDecoration(
      suffixIcon: isIcon ? IconButton(color: Colors.white,onPressed: onTap,icon: Icon(isVisible ?Icons.visibility_outlined : Icons.visibility_off_outlined)) : null,
      hint: Text(hint,style: TextStyle(color: Colors.white),),
      label: Text(label,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3)
        )
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: Colors.white.withOpacity(0.3)
          )
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
            color: Colors.white,
        )
    ),

  );
}