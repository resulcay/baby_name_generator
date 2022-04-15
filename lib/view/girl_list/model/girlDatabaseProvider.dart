import 'package:baby_name_generator/girl_model.dart';
import 'package:sqflite/sqflite.dart';

class GirlDatabaseProvider {
  static late Database database;
  static const String _girlDBpath = "dbForGirl";
  static const int _version = 1;
  static const String _girlTableName = "Girls";
  static const String columnGirlId = "girlId";
  static const String columnName = "name";
  static const String columnDescription = "description";

  Future<void> openDBforGirls() async {
    database = await openDatabase(_girlDBpath, version: _version,
        onCreate: (db, version) {
      createTable(db);
    });
  }

  createTable(Database db) {
    db.execute(
        "CREATE TABLE $_girlTableName ( $columnGirlId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName VARCHAR(25),$columnDescription VARCHAR(100), hint TEXT )");
  }

  Future<List<Girl>> getGirls() async {
    List<Map<String, dynamic>> girlMapList =
        await database.query(_girlTableName);
    return girlMapList.map((e) => Girl.fromJson(e)).toList();
  }

  Future<Girl?> getGirl(int id) async {
    final girlMapList = await database.query(
      _girlTableName,
      where: '$columnGirlId = ?',
      columns: [columnGirlId],
      whereArgs: [id],
    );

    if (girlMapList.isNotEmpty) {
      return Girl.fromJson(girlMapList.first);
    } else {
      return null;
    }
  }

  Future<bool> deleteGirl(int id) async {
    final girlMapList = await database.delete(
      _girlTableName,
      where: '$columnGirlId = ?',
      whereArgs: [id],
    );

    return girlMapList != null;
  }

  Future<bool> updateGirl(int id, Girl girl) async {
    final girlMapList = await database.update(
      _girlTableName,
      girl.toJson(),
      where: columnGirlId,
      whereArgs: [id],
    );

    return girlMapList != null;
  }

  Future<bool> addGirl(Girl female) async {
    List<Map<String, dynamic>> maps = await database.rawQuery(
        "SELECT*FROM $_girlTableName WHERE  $columnName='" + female.name + "'");

    if (maps.isNotEmpty) {
      return false;
    }

    final girlMapList = await database.insert(
      _girlTableName,
      female.toJson(),
    );

    return girlMapList != null;
  }

  Future<void> closeDBforGirls() async {
    await database.close();
  }

  Future<void> cleanDatabaseForGirls() async {
    String start = 'delete from ';
    await database.execute(start + _girlTableName);
  }
}
