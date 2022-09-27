import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:cgpa_calculator_/models/course_model.dart';
import 'package:cgpa_calculator_/models/user_model.dart';

class CgpaDatabase {
  static final CgpaDatabase instance = CgpaDatabase._init();
  static Database? _database;
  CgpaDatabase._init();

  Future _createDb(Database db, int version) async {
    const userUserNameType = 'TEXT PRIMARY KEY NOT NULL';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    Batch batch = db.batch();

    batch.execute(''' CREATE TABLE $userTable(
      ${UserFields.username} $userUserNameType,
      ${UserFields.name} $textType
    )''');

    batch.execute(''' CREATE TABLE $cgpaTable(
      ${CourseFields.username} $textType,
      ${CourseFields.unit} $integerType,
      ${CourseFields.grade} $textType,
      ${CourseFields.title} $textType,
      ${CourseFields.code} $textType,
      ${CourseFields.level} $textType,
      ${CourseFields.semester} $textType,
       FOREIGN KEY (${CourseFields.username}) REFERENCES $userTable (${UserFields.username})
    )''');

    await batch.commit();
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> _initDb(String fileName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, fileName);

    return await openDatabase(
      path,
      onCreate: _createDb,
      onConfigure: _onConfigure,
      version: 2,
    );
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDb('cgpa.db');
      return _database;
    }
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  //CRUD functions for user

  //To create a new user
  Future<User> createUser(User user) async {
    final db = await instance.database;
    db!.insert(
      userTable,
      user.toJson(),
    );
    return user;
  }

  //Read a singular user
  Future<User> getUser(String username) async {
    final db = await instance.database;
    final maps = await db!.query(userTable,
        columns: UserFields.allFields,
        where: '${UserFields.username} = ?',
        whereArgs: [
          username,
        ]);
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw FormatException('$username not found in the database');
    }
  }

  Future<List<User>> getAllUsers() async {
    final db = await instance.database;
    final result = await db!.query(
      userTable,
      orderBy: '${UserFields.username} = ASC',
    );
    return result.map((e) => User.fromJson(e)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return db!.update(
      userTable,
      user.toJson(),
      where: '${UserFields.username} = ?',
      whereArgs: [
        user.username,
      ],
    );
  }

  Future<int> deleteUser(String username) async {
    final db = await instance.database;
    return db!.delete(
      userTable,
      where: '${UserFields.username} = ?',
      whereArgs: [
        username,
      ],
    );
  }

  //CRUD function for cgpa

  Future<Course> createCgpa(Course course) async {
    final db = await instance.database;
    db!.insert(
      cgpaTable,
      course.toJson(),
    );
    return course;
  }

  Future<List<Course>> getAllCgpa(String username) async {
    final db = await instance.database;
    final result = await db!.query(cgpaTable,
        orderBy: '${CourseFields.code} DESC',
        where: '${CourseFields.username} = ?',
        whereArgs: [
          username,
        ]);
    return result.map((e) => Course.fromJson(e)).toList();
  }

  Future<int> deleteCgpa(Course course) async {
    final db = await instance.database;
    return db!.delete(
      cgpaTable,
      where: '${CourseFields.code} = ? AND ${CourseFields.username} = ?',
      whereArgs: [
        course.code,
        course.username,
      ],
    );
  }

  // Future<Course> getGpa(String username) async {
  //   final db = await instance.database;
  //   final maps = await db!.query(cgpaTable,
  //       columns: CourseFields.allFields,
  //       where: '${CourseFields.username} = ?',
  //       whereArgs: [username]);
  //   if (maps.isNotEmpty) {
  //     return Course.fromJson(maps.first);
  //   } else {
  //     throw FormatException('$username not found');
  //   }
  // }
}
