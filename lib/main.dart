import 'package:flutter/material.dart';
import 'package:parcial_1/CRUD/home.dart';
import 'package:parcial_1/login.dart';

final usuario = "JUANDAVID";
var img =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJhw_m2x5q2SR64BoxUo_kf-vtdpG_d-c_-w&usqp=CAU';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
    theme: ThemeData(
      primaryColor: Colors.green,
      //scaffoldBackgroundColor: Colors.white, JUANDAVID
    ),
  ));
}
