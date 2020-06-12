class ReportModel {
  int _id;
  String _writer, _date, _reportTxt;

  ReportModel(this._writer, this._date, [this._reportTxt]);

  ReportModel.withId(this._id, this._writer, this._date, [this._reportTxt]);

  int get id => _id;
  String get name => _writer;
  String get date => _date;
  String get password => _reportTxt;

  set name(String newTitle) {
    if (newTitle.length <= 255) {
      this._writer = newTitle;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set password(String newDescription) {
    if (newDescription.length <= 255) {
      this._reportTxt = newDescription;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map['writer'] = _writer;
    map['date'] = _date;
    map['reportTxt'] = _reportTxt;

    return map;
  }

  ReportModel.fromMapOject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._writer = map['writer'];
    this._date = map['date'];
    this._reportTxt = map['reportTxt'];
  }
}
