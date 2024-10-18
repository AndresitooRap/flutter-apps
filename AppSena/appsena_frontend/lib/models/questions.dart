class Questions {
  final String text, answer;

  Questions({
    required this.text,
    required this.answer,
  });
}

List<Questions> questions = [
  Questions(
    text: '¿Dónde se ubican?',
    answer: "Nosotros nos ubicamos en Cl. 17, Mosquera, Cundinamarca",
  ),
  Questions(
    text: '¿Qué horarios de atención\ntienen?',
    answer:
        "Nuestros horarios de atención son de Lunes a Viernes de 9 am hasta las 6 pm",
  ),
  Questions(
    text: '¿Hacen domicilios?',
    answer: "Por el momento nuestra entidad no cuenta con medios de domicilio",
  ),
  Questions(
    text: '¿Ofrecen otras cosas\naparte de lo que\nmuestran?',
    answer:
        "Por el momento solo ofrecemos lo que hay en el amplio catálogo de productos",
  ),
  Questions(
    text: '¿Puedo cancelar mi pedido\na última hora?',
    answer: "Sí, puedes cancelar el pedido a último momento",
  ),
  Questions(
    text: '¿Qué metodos de pago\naceptan?',
    answer: "Recibimos Nequi, Daviplata, efectivo y Mastercard",
  ),
  Questions(
    text: '¿Qué beneficios tiene\nadquirir sus\nproductos?',
    answer:
        "Estos productos son cultivados y producidos por nuestros aprendices, algo importante para el aprendizaje y desarrollo de nuestra comunidad, más que un beneficio es un apoyo a todas esas personas que dedican mucho de su tiempo para toda esta producción",
  ),
];
