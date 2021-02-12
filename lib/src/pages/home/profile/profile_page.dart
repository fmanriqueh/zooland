import 'package:flutter/material.dart';

import 'package:zooland/src/providers/pets_provider.dart';
import 'package:zooland/src/providers/profile_provider.dart';
import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/widgets/horizontal_divider.dart';
import 'package:zooland/src/widgets/pet_profile.dart';
import 'package:zooland/src/widgets/rounded_button.dart';
import 'package:zooland/src/widgets/user_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StreamBuilder(
          stream: ProfileProvider.instance.subscribeProfile(),
          builder: (context, snapshot) {
            return FutureBuilder(
              future: ProfileProvider.instance.fetchProfile(Auth.instance.user.uid),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return UserProfile(profileModel: snapshot.data, isEditable: true,);
                }else if(snapshot.hasError){
                  return Center(child: Text('Algo salió mal...'));
                }
                return UserProfile();
              }
            );
          }
        ),
        HorizontalDivider(text: 'Mascotas'),
        StreamBuilder<Object>(
          stream: ProfileProvider.instance.subscribePets(),
          builder: (context, snapshot) {
            return FutureBuilder(
              future: PetsProvider.instance.fetchPets(Auth.instance.user.uid),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  if(snapshot.data.length == 0){
                    return Container(height: 0.0, width: 0.0);
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                        stream: PetsProvider.instance.subscribePet(snapshot.data[index].uid),
                        builder: (context, snapshotEvent) {
                          return FutureBuilder(
                            future: PetsProvider.instance.fetchPet(snapshot.data[index].uid),
                            builder: (context, snapshotPet) {
                              if(snapshotPet.hasData) {
                                return PetProfile(petModel: snapshotPet.data, isEditable: true,);
                              }else if(snapshotPet.hasError) {
                                return Center(child: Text('Algo salió mal...'));
                              }
                              return Container(width: 0.0, height: 0.0);
                            }
                          );
                        }
                      );
                    }
                  );
                }else if(snapshot.hasError){
                  return Center(child: Text('Algo salió mal..'));
                }
                return Container(height: 0.0,width: 0.0,);
              }
            );
          }
        ),
        Center(
          child: RoundedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/add-pet');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.pets
                ),
                SizedBox(width:10.0),
                Text('Agregar mascota')
              ]
            )
          ),
        ),
      ],
    );
  }
}