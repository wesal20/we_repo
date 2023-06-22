import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class NottyButtons {
  final String texty;
  VoidCallback ontap;
  bool isSelected ;
NottyButtons({
  this.isSelected =false,
 required this.ontap,
 required this.texty, 
 
});

}
