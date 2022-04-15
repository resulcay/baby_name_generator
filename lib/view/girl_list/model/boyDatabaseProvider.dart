import 'package:baby_name_generator/local_storage.dart';
import 'package:sqflite/sqflite.dart';

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
    print("Boys fetched Successfuly");
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
      print("Boy fetched Successfuly");
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
    print("Deleted Successfuly");
    return boyMapList != null;
  }

  Future<bool> updateBoy(int id, Boy boy) async {
    final boyMapList = await database2.update(
      _boyTableName,
      boy.toJson(),
      where: columnBoyId,
      whereArgs: [id],
    );
    print("Updated Successfuly");
    return boyMapList != null;
  }

  Future<bool> addBoy(Boy male) async {
    List<Map<String, dynamic>> maps = await database2.rawQuery(
        "SELECT*FROM $_boyTableName WHERE  $columnName='" + male.name + "'");

    if (maps.isNotEmpty) {
      print("not added");
      return false;
    }

    final boyMapList = await database2.insert(
      _boyTableName,
      male.toJson(),
    );

    print("Added Successfuly");
    return boyMapList != null;
  }

  Future<void> closeDBforBoys() async {
    await database2.close();
  }

  Future<void> cleanDatabaseForBoys() async {
    String start = 'delete from ';
    await database2.execute(start + _boyTableName);
    print("Clean Succesful");
  }
}
