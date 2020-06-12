class UsersModel {
  int _id;
  String _name, _password;

  UsersModel(this._name, [this._password]);

  UsersModel.withId(this._id, this._name, [this._password]);

  int get id => _id;
  String get name => _name;
  String get password => _password;

  set name(String newTitle) {
    if (newTitle.length <= 255) {
      this._name = newTitle;
    }
  }

  set password(String newDescription) {
    if (newDescription.length <= 255) {
      this._password = newDescription;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map['name'] = _name;
    map['password'] = _password;

    return map;
  }

  UsersModel.fromMapOject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._password = map['password'];
  }
}
