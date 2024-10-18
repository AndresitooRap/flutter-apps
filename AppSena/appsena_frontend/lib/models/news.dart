import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class News {
  final String name, description, img;
  final VoidCallback press;

  News(
      {required this.name,
      required this.description,
      required this.img,
      required this.press});
}

List<News> news = [
  News(
    name: 'Se estrena nuevo ambiente de formación',
    img: 'news_1.jpg',
    description:
        "El CBA de Mosquera se convierte en el cuarto\ncentro de formación a nivel nacional que cuenta\ncon una planta de cervecería artesanal",
    press: () {
      _launchUrl1();
    },
  ),
  News(
    name: 'CampeSENA',
    img: 'news_2.jpg',
    description:
        "Este martes 21 de febrero se realizó el\nlanzamiento de esta estrategia de atención\nintegral para campesinas y campesinos",
    press: () {
      _launchUrl2();
    },
  ),
  News(
    name: '¿Te Estas interesando?',
    img: 'news_3.jpg',
    description: "Unete a nuestra institución, la mejor\nde la sabana ❤",
    press: () {
      _launchUrl3();
    },
  )
];

final Uri _url1 = Uri.parse(
    "https://www.sena.edu.co/es-co/Noticias/Paginas/noticia.aspx?IdNoticia=4916");

Future<void> _launchUrl1() async {
  if (!await launchUrl(_url1)) {
    throw Exception('Could not launch $_url1');
  }
}

final Uri _url2 = Uri.parse(
    "https://www.sena.edu.co/es-co/Noticias/Paginas/noticia.aspx?IdNoticia=6365");

Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
    throw Exception('Could not launch $_url2');
  }
}

final Uri _url3 = Uri.parse(
    "https://oferta.senasofiaplus.edu.co/sofia-oferta/buscar-oferta-educativa.html?radio=opcion199&buscador_texto=Ej%3A+Cocina%2C+Contabilidad&ffv=-1&ciudad=Ej%3A+Cali%2C+Cartagena&campoEmpresa=&nfct=-1");

Future<void> _launchUrl3() async {
  if (!await launchUrl(_url3)) {
    throw Exception('Could not launch $_url3');
  }
}
