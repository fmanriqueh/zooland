class MatchList {
  List<MatchModel> _matchList;

  List<MatchModel> fromJSON(pets){
    _matchList = List();
    pets.forEach((uid, data) {
      _matchList.add(MatchModel().fromJson(uid, data));
    });
    return _matchList;
  }
}

class MatchModel {
  String uid;
  List<UserMatch> participants;

  MatchModel({
    this.uid,
    this.participants
  });

  MatchModel fromJson(uid, _participants) {
    this.uid = uid;
    this.participants = List();
    _participants.forEach((uid, participant) {
      this.participants.add(UserMatch().fromJson(uid, participant));
    });
    /*
    _participants.forEach((id, participant) {
      this.participants.add(UserMatch().fromJson(uid, participant));
    });
    */
    return this;
  }

  Map<String, dynamic> toJson(){
    final map = Map<String,dynamic>();
    participants.forEach((element) { 
      map.putIfAbsent(element.uid, () => element.toJson());
    });
    return map;
  }
}

class UserMatch {
  String uid;
  String name;
  String petId;
  String petName;
  String petPicture;

  UserMatch({
    this.uid,
    this.name,
    this.petId,
    this.petName,
    this.petPicture
  });

  UserMatch fromJson(uid, userMatch) {
    this.uid = uid;
    this.name = userMatch['name'];
    this.petId = userMatch['petId'];
    this.petName = userMatch['petName'];
    this.petPicture = userMatch['petPicture'];
    return this;
  }

  Map<String, String> toJson() => {
    'name'       : this.name,
    'petId'      : this.petId,
    'petName'    : this.petName,
    'petPicture' : this.petPicture
  };
}

/*


{
  'matchs' : {
    'matchId' : {
      'userId' : {
        'name'       : 'name',
        'petName'    : 'petName',
        'petId'      : 'petId',
        'petPicture' : 'petPicture'
      },
      'userId' : {
        'name'       : 'name',
        'petName'    : 'petName',
        'petId'      : 'petId',
        'petPicture' : 'petPicture'
      }
    }
  }

}
*/