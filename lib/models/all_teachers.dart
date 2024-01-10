class AllTeachers {
  final String id, filterTeatcher, fname, lname, img, fnum, country;
  AllTeachers({required this.id,required this.filterTeatcher,required this.fname,required this.lname,required this.img,
    required  this.fnum,required this.country});
  factory AllTeachers.fromJson(jsonData)
  {
    return AllTeachers(id: jsonData['id'],
        filterTeatcher: jsonData['filterTeatcher'],
        fname: jsonData['fname'],
        lname: jsonData['lname'],
        img: jsonData['img'],
        fnum: jsonData['fnum'],
        country: jsonData['country']);
  }
}
