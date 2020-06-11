class Products {
  int _id, _priority;
  String _title;
  String _description;
  String _date;
  String _barcode;

  Products(this._title, this._date, this._priority, this._barcode,
      [this._description]);

  Products.withId(
      this._id, this._title, this._date, this._priority, this._barcode,
      [this._description]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  String get barcode => _barcode;
  int get priority => _priority;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set barCode(String newBarcode) {
    if (newBarcode.length <= 255) {
      this._barcode= newBarcode;
    }
  }

  //convert note object into map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    map['barcode'] = _barcode;

    return map;
  }

  //extract note obj from map obj
  Products.fromMapOject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._barcode = map['barcode'];
  }
}
