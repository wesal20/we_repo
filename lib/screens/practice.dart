import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notty/model/buttons_models.dart';
import 'package:notty/model/moder_notes.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {

   int selected = 0;
   void change (index){
    setState(() {
      selected = index;
    });
   }
  List<NottyButtons> tagy =[
    NottyButtons(texty: 'all' ,ontap: () {
      print('all');
    }),
    
    NottyButtons(texty: 'personal',
     ontap: () =>('personal'),),
    NottyButtons(texty: 'work', ontap: () => print('work'),),
  ];

   double getTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 20.0),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width + 16.0; // Add some padding to the width
  }

  @override
   
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 14, 14, 14),
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Container(
              height: 50,

              
              child: ListView.separated(
                itemCount: tagy.length,
                scrollDirection: Axis.horizontal,
                itemBuilder:(context , index){
                  return GestureDetector(
                    onTap:()=> change(index),
                    child: Container(
                        padding: EdgeInsets.only(top: 5),
                          width: getTextWidth(tagy[index].texty),
                          height: 50,
                          decoration: BoxDecoration(
                            color: selected  == index ?Color.fromARGB(255, 126, 168, 89) : null
                            ,
                          borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: Colors.white, width: 2)),
                    
                        
                          child:Text(tagy[index].texty,textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white,fontSize: 20,),),
                     
                    ),
                  );
                },
                separatorBuilder: (context , index){
                  return SizedBox(width: 
                  10,);
                },
               ),
            )
          ],
        ),
      ),
    );
  }
}
