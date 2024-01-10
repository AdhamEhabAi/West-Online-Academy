class UserModel {
  final String id, fname, lname, img, fnum, country, uname, upass,yr;

  UserModel(
      {required this.id,
      required this.fname,
      required this.lname,
      required this.img,
      required this.fnum,
      required this.country,
      required this.uname,
      required this.upass,
      required this.yr});
  factory UserModel.fromJson(jsonData) {
    return UserModel(
        id: jsonData['id'] ?? '',
        fname: jsonData['fname'] ?? '',
        lname: jsonData['lname'] ?? '',
        img: jsonData['img'] ?? '',
        fnum: jsonData['fnum'] ?? '',
        country: jsonData['country'] ?? '',
        uname: jsonData['uname'] ?? '',
        upass: jsonData['upass'] ?? '',
      yr: jsonData['yr'] ?? '',
    );
  }
}
