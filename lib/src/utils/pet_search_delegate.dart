import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:zooland/src/models/pet_model.dart';
import 'package:zooland/src/providers/pets_provider.dart';

class PetSearchDelegate extends SearchDelegate {

  @override
  final String searchFieldLabel;

  PetSearchDelegate(this.searchFieldLabel);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = '',
      )
    ];
  }
  
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => this.close(context, null)
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    if(this.query == ''){
      return Container(height: 0.0, width: 0.0,);
    }

    return FutureBuilder(
      future: PetsProvider.instance.searchPet(this.query),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return _showPet(snapshot.data, context);
        }else if(snapshot.hasError) {
          return Text('Algo salió mal...');
        }
        return Center(
          child: Container(
            color: Colors.transparent,
            child: CupertinoActivityIndicator(
              radius: 15
            )
          )
        );
      }
    );
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {

    if(this.query == ''){
      return Container(height: 0.0, width: 0.0,);
    }

    return FutureBuilder(
      future: PetsProvider.instance.searchPet(this.query),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return _showPet(snapshot.data, context);
        }else if(snapshot.hasError) {
          return Text('Algo salió mal...');
        }
        return Center(
          child: Container(
            color: Colors.transparent,
            child: CupertinoActivityIndicator(
              radius: 15
            )
          )
        );
      }
    );
  }

  Widget _showPet(List<PetModel> pets, BuildContext context) {
    return ListView.builder(
      itemCount: pets.length,
      itemBuilder: (_, index) {
        final pet = pets[index];
        return ListTile(
          title: Text(pet.name),
          subtitle: Text('${pet.type} | ${pet.breed}'),
          contentPadding: EdgeInsets.symmetric(horizontal:20.0, vertical: 7.0),
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              pet.pictureUrl
            ),
          ),
          trailing: Icon(
            pet.sex == 'masculino' ?  MdiIcons.genderMale : MdiIcons.genderFemale,
            color: pet.sex == 'masculino' ? Colors.blue : Colors.pink,
          ),
          onTap: () {
            Navigator.of(context).pushNamed('/see-profile', arguments: pet.ownerId);
          },
        );
      } 
    );
  }

}