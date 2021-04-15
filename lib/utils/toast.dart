
import 'package:flutter/material.dart';

toast(GlobalKey<ScaffoldState> key,String msg){
  key.currentState.showSnackBar(SnackBar(content: Text(msg)));

}