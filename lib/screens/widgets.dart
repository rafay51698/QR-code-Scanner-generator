import 'package:flutter/material.dart';

AppBar appbar(title) {
  return AppBar(
    foregroundColor: Colors.black,
    
    title: Text(
      
      title,
      style:const TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
  );
}