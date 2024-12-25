class OnBoard {
  final String image, imageLight, title;

  OnBoard({
    required this.image,
    required this.imageLight, 
    required this.title
  }); 
}

final List<OnBoard> demoData = [
    OnBoard(
      image: "assets/1D.png", 
      imageLight: "assets/1W.jpg", 
      title: "Générer vos mots de passe et\ngardez les dans un seul endroit"
    ),
    OnBoard(
      image: "assets/2.png", 
      imageLight: "assets/2.png",
      title: "Retrouvez vos mots de passe\nsur vos nouveaux appareils"
    ),
    OnBoard(
      image: "assets/3D.png", 
      imageLight: "assets/3W.png",
      title: "Simplifiez vous la vie avec\nPassMaker"
    ),
  ];
