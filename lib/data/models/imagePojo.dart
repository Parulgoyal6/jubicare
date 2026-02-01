class Imagepojo {

  final String name;
  final String className;
  final String image;


  Imagepojo({
   required this.name,
   required this.className,
   required this.image
});

  static const String tableName = "Appointments";

  static const String columnName = "name";
  static const String columnclassName = "className";
  static const String columnImage = "image";



  static const String createTable =
      "CREATE TABLE $tableName("
      "$columnName TEXT,"
      "$columnclassName TEXT,"
      "$columnImage TEXT)";

  factory Imagepojo.fromJson(Map<String, dynamic>json){
return Imagepojo(
  name : json["name"],
  className : json["className"],
  image : json["image"]
);
  }

factory Imagepojo.fromMap(Map<String, dynamic> json){
    return Imagepojo(
        name : json["name"],
        className : json["className"],
        image : json["image"]
    );
}


Map<String, dynamic>toJson(){
return{
  "name" : name,
  "className" : className,
  "image": image
};
}
}