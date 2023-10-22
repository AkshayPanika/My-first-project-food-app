import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'card_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY, productName TEXT, productTag TEXT, projectImage TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, ratting INTEGER)');
  }

  ///___ insert table
  Future<CardModel> insert(CardModel card) async {
    print(card.toMap());
    var dbClient = await db;
    await dbClient!.insert('cart', card.toMap());
    return card;
  }

  ///___ getCartList
  Future<List<CardModel>> getCartList() async {
    var dbClient = await db;
    final List<Map<String,Object?>> queryResult = await dbClient!.query('cart');
    return queryResult.map((e) => CardModel.fromMap(e)).toList();
  }

  ///___Delete
  Future<int> delete(int id)async{
    var dbClient = await db;
    return await dbClient!.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  ///___ Update
  Future<int> updateQuantity(CardModel cart)async{
    var dbClient = await db;
    return await dbClient!.update(
      'cart',
      cart.toMap(),
      where: 'id = ?',
      whereArgs: [cart.id],
    );

  }
}
