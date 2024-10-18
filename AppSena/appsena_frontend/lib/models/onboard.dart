class OnBoard {
  final String image, text1, text2;

  OnBoard({required this.image, required this.text1, required this.text2});
}

List<OnBoard> onboards = [
  OnBoard(
    image: 'onboard_1.png',
    text1: '¡Bienvenido A\nLa Tienda SENA!',
    text2: 'La Mejor Distribuidora De La Zona\nPor Nuestros Aprendizes',
  ),
  OnBoard(
    image: 'onboard_2.png',
    text1: 'Las Mejores\nElecciones',
    text2: 'Al Alcanze De Unos Clicks Para Tí',
  ),
  OnBoard(
    image: 'onboard_3.png',
    text1: '¿Listo Para\nEmpezar? ',
    text2: '¡Empezemos, Presiona El Botón!',
  ),
];
