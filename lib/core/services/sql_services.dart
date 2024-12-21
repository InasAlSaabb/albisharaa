import 'package:albisharaa/core/data/models/apis/versemodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'albishara.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 5, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("upp*******************");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    //exexec one time
    batch.execute('''
      CREATE TABLE "trans" (
        "id" INTEGER PRIMARY KEY,
        "name" TEXT,
        "tp" INTEGER,
        "basl" TEXT,
        "chrcnt" INTEGER,
        "trans" TEXT
      )
    ''');

    batch.execute('''
      CREATE TABLE "chapters" (
        "chnr" INTEGER,
        "sfrnr" INTEGER,
        "trans" TEXT,
        FOREIGN KEY (sfrnr) REFERENCES tran(id)
      )
    ''');

    batch.execute('''
      CREATE TABLE "verses" (
        "id" INTEGER,
        "sfrnr" INTEGER,
        "hid" TEXT,
        "chnr" INTEGER,
        "vnumber" INTEGER,
        "textch" TEXT,
        "tid" TEXT,
        "trans" TEXT,
        FOREIGN KEY (sfrnr) REFERENCES trans(id),
        FOREIGN KEY (chnr) REFERENCES chapters(chnr)
      )
    ''');
    batch.execute('''
CREATE TABLE "asfar"(
"id" INTEGER ,
"name" TEXT ,
"tp" INTEGER,
"basl" TEXT ,
"chrcnt" INTEGER ,
"kaComp" INTEGER
)
        ''');
    batch.commit();
    print("CREATE ********************");
  }

  Future<List<Map<String, dynamic>>> readData(
    String sql,
    List<Object> params,
  ) async {
    // Get the database instance
    Database? mydb = await db;

    List<Map<String, dynamic>> response = await mydb!.rawQuery(sql, params);

    print("read***********");

    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<bool> recordExists(String table, int id) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> result = await mydb!.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  mydeletDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'inas.db');
    await deleteDatabase(path);
  }

  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response.toSet();
  }

  readmod(
    String table, {
    String? where,
    List<Object>? whereArgs,
    List<String>? columns,
  }) async {
    Database? mydb = await db;
    // استعلام البيانات
    List<Map<String, dynamic>> response = await mydb!.query(
      table,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );

    print("Response: $response"); // طباعة النتائج

    // تحقق من وجود بيانات
    if (response.isEmpty) {
      print("No data found.");
      return {}; // أو يمكنك إرجاع مجموعة فارغة
    }

    return response;
  }

  insert(String table, Map<String, Object?> val) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, val);
    print("***************insert");
    return response;
  }

  Future<List<VerseModel>> searchOldTestament(String searchText) async {
    final results = await _db!.rawQuery(
        'SELECT verses.* FROM verses INNER JOIN trans ON verses.sfrnr = trans.id WHERE verses.textch LIKE ? AND trans.tp = 1',
        ['%$searchText%']);
    return results.map((map) => VerseModel.fromJson(map)).toList();
  }

  Future<List<VerseModel>> searchNewTestament(String searchText) async {
    final results = await _db!.rawQuery(
        'SELECT verses.* FROM verses INNER JOIN trans ON verses.sfrnr = trans.id WHERE verses.textch LIKE ? AND trans.tp = 2',
        ['%$searchText%']);
    return results.map((map) => VerseModel.fromJson(map)).toList();
  }
}
