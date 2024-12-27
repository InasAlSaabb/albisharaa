// import 'package:albisharaa/core/data/models/apis/versemodel.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

// class DatabaseService {
//   static Future<Database> initDatabase() async {
//     return await openDatabase(
//       'albishara.db',
//       version: 5,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE verses (
//             id INTEGER PRIMARY KEY,
//             sfrnr INTEGER,
//             hid TEXT,
//             chnr INTEGER,
//             vnumber INTEGER,
//             textch TEXT,
//             tid TEXT
//           )
//         ''');
//       },
//     );
//   }

//   static Future<void> saveVerses(List<VerseModel> verses) async {
//     final db = await initDatabase();
//     final batch = db.batch();

//     for (var verse in verses) {
//       batch.insert('verses', {
//         'id': verse.id,
//         'sfrnr': verse.sfrnr,
//         'hid': verse.hid,
//         'chnr': verse.chnr,
//         'vnumber': verse.vnumber,
//         'textch': verse.textch,
//         'tid': verse.tid,
//       });
//     }

//     await batch.commit();
//     print("CREATE ************************************");
//   }

//   static Future<List<VerseModel>> searchVerses(
//       String searchTerm, int sefrId) async {
//     final db = await initDatabase();
//     final results = await db.query(
//       'verses',
//       where: 'sfrnr = ? AND textch LIKE ?',
//       whereArgs: [sefrId, '%$searchTerm%'],
//     );

//     return results.map((map) => VerseModel.fromJson(map)).toList();
//   }

//   static Future<List<VerseModel>> searchALLVerses(String searchTerm) async {
//     final db = await initDatabase();
//     final results = await db.query(
//       'verses',
//       where: 'textch LIKE ?',
//       whereArgs: ['%$searchTerm%'],
//     );

//     return results.map((map) => VerseModel.fromJson(map)).toList();
//   }

//   Future<List<VerseModel>> searchAllBooks(String searchText) async {
//     final database = await initDatabase();
//     final results = await database.rawQuery(
//         'SELECT verses.* FROM verses INNER JOIN trans ON verses.id = trans.id WHERE textch LIKE ?',
//         ['%$searchText%']);
//     return results.map((map) => VerseModel.fromJson(map)).toList();
//   }
// }
