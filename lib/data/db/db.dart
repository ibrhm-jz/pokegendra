import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  Future<Database> openDb() async {
    return openDatabase(join(await getDatabasesPath(), 'pokemon.db'),
        onCreate: (db, version) {
      db.execute(
        "CREATE TABLE pokemones(id INTEGER PRIMARY KEY,name TEXT,imagen TEXT,teamId INTEGER, pokemonId INTEGER)",
      );

      db.execute(
        "CREATE TABLE teams(id INTEGER PRIMARY KEY , name TEXT)",
      );
    }, version: 1);
  }
}
