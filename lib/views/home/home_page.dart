import 'package:flutter/material.dart';
import 'package:golden_eyes/api/main_api.dart';
import 'package:golden_eyes/models/dog.dart';
import 'package:golden_eyes/views/activity/register_activity.dart';
import 'package:golden_eyes/widgets/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'widgets/list_view_dogs.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserRepository userRepository;
  List<Dog> dogs = [];
  Widget headerHome(String name) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      color: COLOR_YELLOW,
      padding: const EdgeInsets.only(left: 20.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Olá, $name!",
            style: TextStyle(
                color: COLOR_BROWN, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Image.asset('assets/images/logo_home.png')),
        ],
      ),
    );
  }

  Widget buttonHome(IconData icon, String text, {onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            child: Icon(
              icon,
              color: COLOR_BROWN,
              size: 25,
            ),
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: COLOR_YELLOW,
                width: 3.5,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context, listen: false);
    return Scaffold(
      backgroundColor: COLOR_LIGHT_GREY,
      appBar: AppBar(
        backgroundColor: COLOR_YELLOW,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.account_circle_outlined,
            color: COLOR_BROWN,
          ),
          onPressed: () => Navigator.pushNamed(context, '/profile'),
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 10.0),
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.search,
          //       color: COLOR_BROWN,
          //     ),
          //     onPressed: () {},
          //   ),
          // ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        color: COLOR_YELLOW,
        child: Column(
          children: [
            Container(
              color: COLOR_BROWN,
              height: 1,
            ),
            headerHome(userRepository.user.name.split(' ')[0]),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: userRepository.isAdmin
                      ? Row(
                          children: [
                            buttonHome(Icons.person_add_alt_sharp, "Função",
                                onTap: () =>
                                    Navigator.pushNamed(context, '/role')),
                            SizedBox(width: 20),
                            buttonHome(Icons.pets, "Cão",
                                onTap: () =>
                                    Navigator.pushNamed(context, '/dog')),
                            SizedBox(width: 20),
                            buttonHome(Icons.calendar_today, "Atividade",
                                onTap: () =>
                                    Navigator.pushNamed(context, '/activity')),
                          ],
                        )
                      : SizedBox(),
                ),
              ),
            ),
            SizedBox(height: 30),
            FutureBuilder(
              future: MainApi.dog.getAllDog(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null &&
                    snapshot.connectionState == ConnectionState.done) {
                  dogs = snapshot.data;
                  return listViewDog(snapshot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var coachList = await MainApi.user.getCoachList(userRepository.token);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) => RegisterActivity(
                        dogList: dogs,
                        coachList: coachList,
                      )));
        },
        backgroundColor: COLOR_BROWN,
        child: Icon(
          FontAwesomeIcons.paw,
          color: COLOR_YELLOW,
        ),
      ),
    );
  }
}
