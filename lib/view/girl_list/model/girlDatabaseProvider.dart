import 'package:baby_name_generator/local_storage.dart';
import 'package:sqflite/sqflite.dart';

class GirlDatabaseProvider {
  static late Database database;
  static const String _girlDBpath = "girlDB";
  static const int _version = 1;
  static const String _girlTableName = "girl";
  static const String columnGirlId = "girlId";
  static const String columnName = "name";
  static const String columnDescription = "description";

  Future<void> openDBforGirl() async {
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
    print("Girls fetched Successfuly");
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
      print("Girl fetched Successfuly");
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
    print("Deleted Successfuly");
    return girlMapList != null;
  }

  Future<bool> updateGirl(int id, Girl girl) async {
    final girlMapList = await database.update(
      _girlTableName,
      girl.toJson(),
      where: columnGirlId,
      whereArgs: [id],
    );
    print("Updated Successfuly");
    return girlMapList != null;
  }

  Future<bool> addGirl(Girl girl) async {
    final girlMapList = await database.insert(
      _girlTableName,
      girl.toJson(),
    );

    print("Added Successfuly");
    return girlMapList != null;
  }

  Future<void> closeDBforGirl() async {
    await database.close();
  }
}
