import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "WalletDs.db";
  static final _databaseVersion = 1;

  /// User Table
  static final userTable = 'user';
  static final userId = '_id';
  static final userName = 'name';
  static final userJwt = 'JTWkay';
  static final userCreateDate = 'wallet_create_date';

  /// Wallet Table
  static final walletTable = 'wallet_table';
  static final walletId = 'id';
  static final walletName = 'name';
  static final walletBalance = 'wallet_balance';
  static final walletAccountNumber =
      'wallet_type'; // if is false it is a credit card
  static final walletCardNumber = 'wallet_discreption';
  static final walletCreateDate = 'user_create_date';
  static final user_id = 'user_id';

  /// Transaction Table
  static final transactionTable = 'transaction_table';
  static final transactionId = 'transaction_id';
  static final transactionType = 'transaction_type';
  static final transactionValue = 'transaction_value';
  static final transactionDiscreption = 'transaction_discreption';
  static final transactionCreateDate = 'user_create_date';
  static final wallet_id = 'wallet_id';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    debugPrint("******************************:" + _database.toString());
    debugPrint("///////////////////////////////:");
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $userTable (
            $userId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            $userName TEXT NOT NULL,
            $userJwt TEXT NOT NULL,
            $userCreateDate TEXT
          )
          ''');
    await db.execute('''
                CREATE TABLE $walletTable (
            $walletId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            $walletName TEXT NOT NULL,
            $walletBalance INTEGER ,
            $walletCardNumber TEXT ,
            $walletAccountNumber TEXT,
            $walletCreateDate TEXT,
            $user_id TEXT
          )
    ''');

    await db.execute('''
                CREATE TABLE $transactionTable (
            $transactionId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            $transactionDiscreption TEXT ,
            $transactionType INTEGER ,
            $transactionValue INTEGER ,
            $walletName TEXT,
            $transactionCreateDate TEXT,
            $wallet_id TEXT
          )
    ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> InsertIntoUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(userTable, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> QueryAllUserRows() async {
    Database db = await instance.database;
    return await db.query(userTable);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryUserRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $userTable'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> UpdateUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[userId];
    return await db
        .update(userTable, row, where: '$userId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete(userTable, where: '$userId = ?', whereArgs: [id]);
  }

  /// Wallet Sql Queries
  Future<int> InsertIntoWallet(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(walletTable, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> QueryAllWalletRows() async {
    Database db = await instance.database;
    return await db.query(walletTable);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> QueryWalletRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $walletTable'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> UpdateWallet(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[userId];
    return await db
        .update(walletTable, row, where: '$walletId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteWallet(int id) async {
    Database db = await instance.database;
    return await db
        .delete(walletTable, where: '$walletId = ?', whereArgs: [id]);
  }

  /// Transaction Sql Queries
  Future<int> InsertIntoTransaction(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(transactionTable, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> QueryAllTransactionRows() async {
    Database db = await instance.database;
    return await db.query(transactionTable);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> QueryTransactionRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $transactionTable'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> UpdateTransaction(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[userId];
    return await db.update(transactionTable, row,
        where: '$transactionId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteTransaction(int id) async {
    Database db = await instance.database;
    return await db
        .delete(transactionTable, where: '$transactionId = ?', whereArgs: [id]);
  }
}
