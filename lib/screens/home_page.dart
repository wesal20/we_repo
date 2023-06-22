import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notty/model/buttons_models.dart';
import 'package:notty/model/moder_notes.dart';
import 'package:notty/services/database.dart';

class NottyHomePge extends StatefulWidget {
  const NottyHomePge({super.key});

  @override
  State<NottyHomePge> createState() => _NottyHomePgeState();
}

class _NottyHomePgeState extends State<NottyHomePge> {
  var _noteController = TextEditingController();
    var _titleController = TextEditingController();
  int _Selected = 0;
  String name = 'Mo';

  void _selection(int index) {
    setState(() {
      _Selected = index;
    });
  }

  List<NottyButtons> tags = [
    NottyButtons(
      texty: 'all',
      ontap: () {
        print('all');
      },
    ),
    NottyButtons(
      texty: 'personal',
      ontap: () => print('personal'),
    ),
    NottyButtons(
      texty: 'work',
      ontap: () => print('work'),
    ),
    NottyButtons(
      texty: 'study',
      ontap: () => print('study'),
    ),
  ];
  //container width method
  double getTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 25.0),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width + 16.0; // Add some padding to the width
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 12, 12),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/5f/33/2e/5f332ec081b7c51c1bb80c8c9e8a454c.jpg'),
              radius: 15,
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Welcome back $name')
          ],
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.notifications_none),
          SizedBox(
            width: 20,
          ),
        ],
        elevation: null,
      ),
      body: Container(
        color: const Color.fromARGB(255, 12, 12, 12),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  'Your Notes',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Anton-Regular'),
                ),
                const SizedBox(
                  width: 90,
                ),
                InkWell(
                  onTap: () async {
                    await DataBaseHelper.instance.addNottiesToDatabase(
                      MyNotty(content: _noteController.text,
                       title: _titleController.text)
                    );
                    setState(() {
                      _titleController.clear();
                      _noteController.clear();
                      print('Notty has saved');
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              //  color: Colors.amber,
              height: 50, width: double.maxFinite,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5, left: 20),
                      child: InkWell(
                        onTap: () => _selection(index),
                        child: Container(
                          padding: EdgeInsets.only(top: 5),
                          width: getTextWidth(tags[index].texty),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                              color: _Selected == index
                                  ? Color.fromARGB(255, 138, 175, 35)
                                  : null),
                          // color: Colors.white,

                          child: Text(
                            tags[index].texty,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 40,left: 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                   TextField(
                  controller: _titleController,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                   fontWeight: FontWeight.bold 
                  ),
                  onSubmitted: (value) {},
                  decoration: const InputDecoration(
                    hintText: 'Notty Title ',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 52, 52)),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                ),
                 const SizedBox(
              height: 10,
            ),
                  TextField(
                  controller: _noteController,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                       fontStyle: FontStyle.italic
                  ),
                  onSubmitted: (value) {},
                  decoration: const InputDecoration(
                    hintText: 'write a Notty ',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 52, 52)),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20,),
                
             ] ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    width: double.infinity,
                    child: Center(
                      child: FutureBuilder<List<MyNotty>?>(
                          future: DataBaseHelper.instance.getNotties(),
                          builder: (context,
                              AsyncSnapshot<List<MyNotty>?> snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                padding: EdgeInsets.only(top: 100),
                                child: const Text(
                                  'no notes to show 🙈🙈🙈',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              );
                            }
                            return const Center(
                              child: Text('loading .....',style: TextStyle(color: Colors.white,fontSize: 25,
                              fontWeight: FontWeight.bold),),
                            );
                          }),
                    )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
