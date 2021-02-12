class ProfileModel {
  String name;
  String location;
  String pictureUrl;

  ProfileModel(
    {this.name,
    this.location,
    this.pictureUrl});

  ProfileModel fromJson(profile) {
    this.name = profile['name'];
    this.location = profile['location'];
    this.pictureUrl = profile['pictureUrl'];
    return this;
  }

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'location': this.location,
    'pictureUrl': this.pictureUrl
  };
}