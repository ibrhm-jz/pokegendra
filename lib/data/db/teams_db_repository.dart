import 'package:pokegendra/data/db/db.dart';
import 'package:pokegendra/data/models/team_model.dart';
import 'package:sqflite/sqflite.dart';

class TeamDbRepository {
  DB db = DB();
  Future<int> insertTeam(TeamModel teamModel) async {
    Database database = await db.openDb();
    return await database.insert("teams", teamModel.toMap());
  }

  Future<int> deleteTeam(TeamModel teamModel) async {
    Database database = await db.openDb();
    return await database
        .delete("teams", where: "id = ?", whereArgs: [teamModel.id]);
  }

  Future<int> updateTeam(TeamModel teamModel) async {
    Database database = await db.openDb();
    return await database.update("teams", teamModel.toMap(),
        where: "id = ?", whereArgs: [teamModel.id]);
  }

  Future<List<TeamModel>> getTeams() async {
    Database database = await db.openDb();
    final List<Map<String, dynamic>> teams = await database.query('teams');
    return List.generate(
      teams.length,
      (i) => TeamModel(
        id: teams[i]['id'],
        name: teams[i]['name'],
      ),
    );
  }
}
