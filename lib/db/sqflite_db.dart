import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDb {
  static Database? _database ;

  Future<Database?> get database async{
    if(_database == null){
      _database = await init();
      return _database;
    }
    else{
      return _database;
    }
  }


  init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'contacts.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
    return database;
  }

  onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE 'contacts' (id INTEGER PRIMARY KEY, name TEXT, number TEXT, url TEXT)");
    print('Created Successfully....');
  }

  Future<List<Map>> getData()async{
    Database? myDatabase = await database;
    List<Map> response = await myDatabase!.rawQuery("SELECT * FROM 'contacts'");
    return response;

  }

  Future<void> insertData({
    required String name,
    required String number,
    required String url,
  })async{
    Database? myDatabase = await database;
    await myDatabase!.rawInsert("INSERT INTO 'contacts' ('name', 'number', 'url') VALUES('$name', '$number', '$url')");
  }

  Future<int> deleteData({
    required int id,
})async{
    Database? myDatabase = await database;
    int contactId = await myDatabase!.rawDelete("DELETE FROM 'contacts' WHERE id = ?", [id]);
    return contactId;
  }

  Future<int> updateData({
    required int id ,
    required String name,
    required String number ,
    required String url ,
})async{
    Database? myDatabase = await database;
   int contactId = await myDatabase!.rawUpdate("UPDATE 'contacts' SET 'name' = ? , 'number' = ? , 'url' = ? WHERE id = ?",
       [name, number, url, id]);
   print(contactId);
   return contactId;
  }
}