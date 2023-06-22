import 'dart:async';
import 'package:notty/model/moder_notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
  //create database
  Future<Database> _getDB() async {
    //get database path .... the path in the varible 'path '
    String path = join(await getDatabasesPath(), 'NottyDAtabase.db');

    //open database
   return openDatabase(
      join(await getDatabasesPath(), 'NottyDAtabase.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE my_notties_table(id INTEGER PRIMARY KEY ,title TEXT , content TEXT)');
      },
    );
   
  }



////////////// add to database  ///////////
  Future<int> addNottiesToDatabase(MyNotty note) async {
  final db = await _getDB();
     return await db.insert(
      'my_notties_table',
      note.toMap(),
       conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  //update note/////////////////
   Future<int> updateNotties(MyNotty note) async {
  final db = await _getDB();
     return await db.update(
      'my_notties_table',
      note.toMap(),where: 'id = ?',whereArgs: [note.id],
       conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


   //delete note ///////////////////
    Future<int> deleteNotties(MyNotty note) async {
  final db = await _getDB();
     return await db.delete(
      'my_notties_table',
     where: 'id = ?',whereArgs: [note.id],
      
    );
  }


  /// get notes from database ///////
   Future <List<MyNotty>?> getNotties()async{

      final db = await _getDB();
    final List<Map<String,dynamic>> nottiesMap = await db.query('my_notties_table');
    if (nottiesMap.isEmpty) {
      return null;
    }
    return List.generate(nottiesMap.length, (index) => MyNotty.fromMap(nottiesMap[index]));
  }
}
