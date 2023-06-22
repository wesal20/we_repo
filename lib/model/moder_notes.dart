import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class MyNotty {
  final int? id;
  final String title;
  final String content;

  MyNotty({required this.content, this.id, required this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  factory MyNotty.fromMap(Map<String, dynamic> map) {
    return MyNotty(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}





//////conatainer class ////////
class NottyContainer extends StatelessWidget {
  final double withy;
  final double heighty;
  final Text? title;
  final Text? content;
  Color colory ;
  NottyContainer(
      {required this.content,
      required this.heighty,
      this.title,
      required this.withy,
      required this.colory
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20),
      child: Container(
        width: withy,
        height: heighty,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colory,
          
        ),
        child:content
      ),
    );
  }
}
