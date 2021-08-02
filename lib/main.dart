import 'package:flutter/material.dart';
import 'package:bwadr/pages/home.dart';
import 'package:bwadr/pages/loading.dart';
import 'package:bwadr/pages/adr_detail.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    '/home' : (Widget) => Home(),
    '/' : (Widget) => Loading(),
    '/adr_detail' : (Widget) => AdressDetail(),
  },
));

