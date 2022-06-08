import 'package:flutter/material.dart';
import 'package:pokegendra/data/db/teams_db_repository.dart';
import 'package:pokegendra/data/models/team_model.dart';
import 'package:pokegendra/ui/views/teams/teams_detail.dart';

class Teams extends StatefulWidget {
  Teams({Key? key});

  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  List<TeamModel> teams = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeams();
  }

  Future getTeams() async {
    TeamDbRepository teamDbRepository = TeamDbRepository();
    final response = await teamDbRepository.getTeams();
    setState(() {
      teams = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de equipos'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TeamsDetail(
                          id: teams[i].id,
                        ))),
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage('assets/pokeball.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(teams[i].name.toString()),
                    ),
                    Divider(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
