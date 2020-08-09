class UserModel {
  String iD;
  String fullname;
  String username;
  String password;

  UserModel({this.iD, this.fullname, this.username, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    fullname = json['Fullname'];
    username = json['Username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Fullname'] = this.fullname;
    data['Username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

