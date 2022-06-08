import 'package:flutter/material.dart';
import 'package:pokegendra/ui/widgets/default_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DafaultHome extends StatefulWidget {
  DafaultHome({Key? key});

  @override
  _DafaultHomeState createState() => _DafaultHomeState();
}

class _DafaultHomeState extends State<DafaultHome> {
  TextEditingController nameController = TextEditingController();
  bool isLoad = true;
  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user == null) {
      setState(() {
        isLoad = false;
      });
    } else {
      Navigator.pushNamed(context, '/home');
    }
  }

  addName() async {
    if (nameController.text.isNotEmpty) {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('user', nameController.text);
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: isLoad
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Bienvenido \na la Pokédex.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  DefaultField(
                    controller: nameController,
                    hintText: 'Tu nombre',
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      addName();
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: Center(
                        child: Text(
                          'Iniciar',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
