class Datashow {
  String movieTitle;
  String date;


  Datashow(this.movieTitle,this.date);

  Datashow.formMap(Map<dynamic, dynamic>map){
    movieTitle = map['MovieTitle'];
    date = map['Date'];
  }
  
}