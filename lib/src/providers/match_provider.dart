import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:zooland/src/models/match_model.dart';
import 'package:zooland/src/models/pet_model.dart';

class MatchProvider {
  MatchProvider._internal();
  static final MatchProvider instance = MatchProvider._internal();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<MatchModel>> fetchMatch() async {
    final matchRef = _database.reference()
    .child('match')
    .orderByChild(_auth.currentUser.uid);
    
    return await matchRef.once().then((snapshot) {
        if(snapshot.value == null) {
          return List();
        }
        return MatchList().fromJSON(snapshot.value);
    });
  }

  Future<void> createMatch(PetModel ownerPet, PetModel pet) async {

    final UserMatch userMatchOwner = UserMatch(
      petId: ownerPet.uid,
      petName: ownerPet.name,
      petPicture: ownerPet.pictureUrl,
      uid: ownerPet.ownerId
    );
    userMatchOwner.name = _auth.currentUser.displayName;

    final UserMatch userMatch = UserMatch(
      petId: pet.uid,
      petName: pet.name,
      petPicture: pet.pictureUrl,
      uid: pet.ownerId
    );

    await _database.reference()
      .child('users')
      .child(pet.ownerId)
      .once().then((snapshot) {
        userMatch.name = snapshot.value['name'];
      }); 

    final MatchModel matchModel = MatchModel(uid: null, participants: [userMatchOwner, userMatch]);

    final matchRef = _database.reference()
      .child('match')
      .push();
    
    matchRef.set(matchModel.toJson());
  }

}
