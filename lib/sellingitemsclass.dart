class sellingitemsclass {
  String title ;
  var price ;
  String desc;
String? imageurl ;
String category;
String? docid;
String timing;
String condition;
String name;
String roomno;
bool? isBusiness;

   sellingitemsclass({
  required  this.title ,

     required this.price,
required this.desc,
 this.imageurl,
     required this.category,
     required this.condition,
  this.docid,
     required this.timing,
required this.roomno,
     required this.name,
     this.isBusiness,
});


}