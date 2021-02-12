import 'package:flutter/material.dart';
import 'package:zooland/src/providers/pets_provider.dart';
import 'package:zooland/src/providers/profile_provider.dart';
import 'package:zooland/src/widgets/pet_profile.dart';
import 'package:zooland/src/widgets/user_profile.dart';

class SeeProfilePage extends StatelessWidget {
  const SeeProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            FutureBuilder(
              future: ProfileProvider.instance.fetchProfile(uid),
              builder: (_, snapshot) {
                if(snapshot.hasData) {
                  return UserProfile(profileModel: snapshot.data);
                } else if(snapshot.hasError) {
                  return Center(child: Text('Algo salió'));
                }
                return UserProfile();
              }
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: new Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: Divider(
                      color: Colors.black26,
                      height: 36,
                    )
                  ),
                ),
                Text(
                  "Mascotas",
                  style: TextStyle(
                    fontWeight: FontWeight.w400
                  ),
                ),
                Expanded(
                  child: new Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: Divider(
                      color: Colors.black26,
                      height: 36,
                    )),
                ),
              ]
            ),
            FutureBuilder(
              future: PetsProvider.instance.fetchPets(uid),
              builder: (_, snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data.length == 0){
                    return Container(height: 0.0, width: 0.0);
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return PetProfile(petModel: snapshot.data[index]);
                    }
                  );
                } else if(snapshot.hasError) {
                  return Center(child: Text('Algo salió'));
                }
                return Container(height: 0.0, width: 0.0);
              }
            )
          ],
        )
      )
    );
  }
}