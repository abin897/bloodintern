import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';


// import 'user.dart';

class Dbhealper {
  late Database _database;

  Dbhealper() {
    openDb();
  }

  Future<void> openDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), "User.db"),
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
            "CREATE TABLE usertable("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "name TEXT, ph TEXT, age TEXT, blood TEXT, "
                "gender TEXT, donated TEXT, weight TEXT,place TEXT)"
        );
      },
    );
  }

  Future<void> insertuser(User user) async {
    await openDb(); // Ensure database is open
    await _database.insert('usertable', user.toMap());
  }

  Future<int?> updateUser(User user) async {
    await openDb();
    return await _database.update(
      "usertable",
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  Future<int?> deleteUser(User user) async {
    await openDb();
    return await _database.delete(
      "usertable",
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  Future<List<User>?> getAllUsers() async {
    await openDb();
    List<Map<String, dynamic>> map = await _database.query("usertable");
    return List.generate(map.length, (i) {
      return User(
        id: map[i]["id"].toString(),
        name: map[i]["name"],
        ph: map[i]["ph"],
        age: map[i]["age"],
        blood: map[i]["blood"],
        gender: map[i]["gender"],
        donated: map[i]["donated"],
        weight: map[i]["weight"],
        place: map[i]["place"],
      );
    });
  }
}
