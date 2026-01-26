class Imagepojo {

  final String image;


  Imagepojo({
   required this.image
});

  static const String tableName = "Data";

  static const String columnImage = "image";



  static const String createTable =
      "CREATE TABLE $tableName("
      "$columnImage TEXT)";

  factory Imagepojo.fromJson(Map<String, dynamic>json){
return Imagepojo(
  image : json["image"]
);
  }

factory Imagepojo.fromMap(Map<String, dynamic> json){
    return Imagepojo(image : json["image"]);
}


Map<String, dynamic>toJson(){
return{
  "image": image
};
}
}