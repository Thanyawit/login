class Datashow {
  String movieTitle;


  Datashow(this.movieTitle);

  Datashow.formMap(Map<dynamic, dynamic>map){
    movieTitle = map['MovieTitle'];
  }
  
}