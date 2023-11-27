class UserModel {
  String name;
  String phone;
  String email;
  String password;
  String? userid;
  String gender;
  String profilepic;
  bool isActive;
  bool isOnline;

  UserModel({
    required this.password,
    required this.name,
    required this.email,
    required this.phone,
  required this.gender,
  this.userid,
  this.profilepic="",
    this.isActive=true,
    this.isOnline=false
  });


  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        userid: json['userid'],
        password: json['password'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        gender: json['gender'],
        profilepic: json['profilepic'],
      isActive: json['isActive'],
      isOnline: json['isOnline']

    );
  }

  Map<String,dynamic> toJson(){
  return {
    'userid':userid,
    'password':password,
    'name':name,
    'email':email,
    'phone':phone,
    'gender':gender,
    'isActive':isActive,
    'isOnline':isOnline,
    'profilepic':profilepic,
  };
  }

}