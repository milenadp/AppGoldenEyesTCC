import 'package:flutter/material.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context, listen: false);
    return Scaffold(
      backgroundColor: COLOR_LIGHT_GREY,
      appBar: AppBar(
        iconTheme: IconThemeData(color: COLOR_BROWN),
        backgroundColor: COLOR_LIGHT_GREY,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: COLOR_YELLOW,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
            ),
            title: Text(userRepository.user.name.split(' ')[0],
                style:
                    TextStyle(color: COLOR_BROWN, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 50),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => Navigator.pushNamed(context, '/profile/edit'),
                trailing: Icon(Icons.arrow_forward_ios, color: COLOR_BROWN),
                leading: Icon(
                  Icons.person,
                  color: COLOR_BROWN,
                ),
                title: Text("Editar perfil",
                    style: TextStyle(
                        color: COLOR_BROWN, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () async {
                  userRepository.logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                trailing: Icon(Icons.arrow_forward_ios, color: COLOR_BROWN),
                leading: Icon(
                  Icons.keyboard_return,
                  color: COLOR_BROWN,
                ),
                title: Text("Sair do aplicativo",
                    style: TextStyle(
                        color: COLOR_BROWN, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
