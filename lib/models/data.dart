class PhotoModel {
  List<Photos>? data;
  PhotoModel({
    this.data,
  });
  PhotoModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Photos>[];
      json['data'].forEach((v) {
        data!.add(Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (this.data != null) {
      data['data'] = this.data!.join();
    }

    //  if (json['data'] != null) {
    //   data = <Photos>[];
    //   json['photos'].forEach((v) {
    //     photos.add(Photos.fromJson(v));
    //   });
    // }

    return data;
  }
}

class Photos {
  var id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  Photos({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['picture'] = picture;

    return data;
  }
}

class UploadUser {
  String? key;
  String? username;
  String? name;

  UploadUser({
    this.key,
    this.username,
    this.name,
  });
  factory UploadUser.fromJson(Map<String, dynamic> json) {
    return UploadUser(
      key: json['key'],
      username: json['username'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() => {
        'key': key,
        'username': username,
        'name': name,
      };
}

class userDetails {
  var id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? gender;
  String? email;
  var dateOfBirth;
  int? phone;
  var registerDate;
  var updatedDate;

  Location? location;

  userDetails(
      {this.id,
      this.title,
      this.firstName,
      this.lastName,
      this.picture,
      this.gender,
      this.email,
      this.dateOfBirth,
      this.phone,
      this.registerDate,
      this.updatedDate,
      this.location});

  userDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['firstName'];
    picture = json['picture'];
    gender = json['gender'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    phone = json['phone'];
    registerDate = json['registerDate'];
    updatedDate = json['updatedDate'];
    // location =
    //     json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['title'] = this.title;
    data['firstName'] = this.title;
    data['picture'] = this.picture;
    data['gender'] = this.gender;
    data['email'] = this.email;

    data['dateOfBirth'] = this.dateOfBirth;
    data['phone'] = this.phone;
    data['registerDate'] = this.registerDate;
    data['updatedDate'] = this.updatedDate;

    // if (this.location != null) {
    //   data['location'] = this.location!.toJson();
    // }

    return data;
  }
}

class Location {
  var street;
  String? city;
  String? state;
  String? country;
  var timezone;

  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.timezone,
  });

  Location.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['timezone'] = timezone;

    return data;
  }
}
