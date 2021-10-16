class CommentModel{
  String? uid;
  String? comment;

  CommentModel({
   this.uid,
   this.comment
});
  CommentModel.fromJson(Map<String,dynamic> json){
    uid = json['userId'];
    comment = json['comment'];
  }

}