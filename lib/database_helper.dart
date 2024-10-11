import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'voting_system.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE voters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        national_id TEXT NOT NULL UNIQUE,
        has_voted INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE candidates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        party TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE votes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        voter_id INTEGER,
        candidate_id INTEGER,
        FOREIGN KEY (voter_id) REFERENCES voters(id),
        FOREIGN KEY (candidate_id) REFERENCES candidates(id)
      )
    ''');
  }

  // إدخال ناخب جديد
  Future<int> insertVoter(Map<String, dynamic> voter) async {
    Database db = await database;
    return await db.insert('voters', voter);
  }

  // إدخال مرشح جديد
  Future<int> insertCandidate(Map<String, dynamic> candidate) async {
    Database db = await database;
    return await db.insert('candidates', candidate);
  }

  // إدخال تصويت
  Future<int> insertVote(Map<String, dynamic> vote) async {
    Database db = await database;
    return await db.insert('votes', vote);
  }

  // جلب جميع الناخبين
  Future<List<Map<String, dynamic>>> getAllVoters() async {
    Database db = await database;
    return await db.query('voters');
  }

  // جلب جميع المرشحين
  Future<List<Map<String, dynamic>>> getAllCandidates() async {
    Database db = await database;
    return await db.query('candidates');
  }

  // جلب نتائج التصويت
  Future<List<Map<String, dynamic>>> getVoteResults() async {
    Database db = await database;
    return await db.rawQuery('''
      SELECT candidates.name, candidates.party, COUNT(votes.id) as vote_count 
      FROM votes 
      JOIN candidates ON votes.candidate_id = candidates.id 
      GROUP BY candidates.name, candidates.party
    ''');
  }

  // حذف ناخب
  Future<int> deleteVoter(int id) async {
    Database db = await database;
    return await db.delete('voters', where: 'id = ?', whereArgs: [id]);
  }

  // حذف مرشح
  Future<int> deleteCandidate(int id) async {
    Database db = await database;
    return await db.delete('candidates', where: 'id = ?', whereArgs: [id]);
  }
}
