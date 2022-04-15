import 'package:sqflite/sqflite.dart';

import '../../../models/boy_model.dart';

class BoyDatabaseProvider {
  static late Database database2;
  static const String _boyDBpath = "dbForBoy";
  static const int _version = 1;
  static const String _boyTableName = "Boys";
  static const String columnBoyId = "boyId";
  static const String columnName = "name";
  static const String columnDescription = "description";

  Future<void> openDBforBoys() async {
    database2 = await openDatabase(_boyDBpath, version: _version,
        onCreate: (db, version) {
      createTable(db);
    });
  }

  createTable(Database db) {
    db.execute(
        "CREATE TABLE $_boyTableName ( $columnBoyId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName VARCHAR(25),$columnDescription VARCHAR(100))");
  }

  Future<List<Boy>> getBoys() async {
    List<Map<String, dynamic>> boyMapList =
        await database2.query(_boyTableName);
    return boyMapList.map((e) => Boy.fromJson(e)).toList();
  }

  Future<Boy?> getBoy(int id) async {
    final boyMapList = await database2.query(
      _boyTableName,
      where: '$columnBoyId = ?',
      columns: [columnBoyId],
      whereArgs: [id],
    );

    if (boyMapList.isNotEmpty) {
      return Boy.fromJson(boyMapList.first);
    } else {
      return null;
    }
  }

  Future<bool> deleteBoy(int id) async {
    final boyMapList = await database2.delete(
      _boyTableName,
      where: '$columnBoyId = ?',
      whereArgs: [id],
    );
    return boyMapList != null;
  }

  Future<bool> updateBoy(int id, Boy boy) async {
    final boyMapList = await database2.update(
      _boyTableName,
      boy.toJson(),
      where: columnBoyId,
      whereArgs: [id],
    );
    return boyMapList != null;
  }

  Future<bool> addBoy(Boy male) async {
    List<Map<String, dynamic>> maps = await database2.rawQuery(
        "SELECT*FROM $_boyTableName WHERE  $columnName='" + male.name + "'");

    if (maps.isNotEmpty) {
      return false;
    }

    final boyMapList = await database2.insert(
      _boyTableName,
      male.toJson(),
    );

    return boyMapList != null;
  }

  Future<void> closeDBforBoys() async {
    await database2.close();
  }

  Future<void> cleanDatabaseForBoys() async {
    String start = 'delete from ';
    await database2.execute(start + _boyTableName);
  }
}
