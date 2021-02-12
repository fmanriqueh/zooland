class PetsList {
  List<PetModel> _petsList;

  List<PetModel> fromJSON(pets){
    _petsList = List();
    pets.forEach((uid, data) {
      _petsList.add(PetModel().fromJson(uid, data));
    });
    return _petsList;
  }
}

class PetModel {
  String name;
  String pictureUrl;
  String breed;
  String sex;
  String age;
  String type;
  List<String> photos;
  String uid;
  String ownerId;

  PetModel({
    this.name,
    this.pictureUrl,
    this.breed,
    this.sex,
    this.age,
    this.type,
    this.photos,
    this.uid,
    this.ownerId
  });

  PetModel fromJson(uid, pet) {
    this.name = pet['name'];
    this.pictureUrl = pet['pictureUrl'];
    this.breed = pet['breed'];
    this.sex = pet['sex'];
    this.age = pet['age'];
    this.type = pet['type'];
    this.uid = uid;
    this.ownerId = pet['ownerId'];

    photos = List<String>();
    pet['photos']?.forEach((key, value) {
      this.photos.add(value);
    });
    return this;
  }

  Map<String, dynamic> toJson() => {
    'name'      : this.name,
    'pictureUrl': this.pictureUrl,
    'breed'     : this.breed,
    'sex'       : this.sex,
    'age'       : this.age,
    'type'      : this.type,
    'photos'    : this.photos,
    'ownerId'   : this.ownerId
  };
}
