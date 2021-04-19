import 'dart:convert';

class Usuario {
  final String id;
  final String foto;
  final String nombre;
  final String apellido;
  final String profesion;
  final String fechaNacimiento;

  Usuario(
      {this.id,
      this.foto,
      this.nombre,
      this.apellido,
      this.profesion,
      this.fechaNacimiento});

  factory Usuario.fromJson(Map<String, dynamic> json) => new Usuario(
        id: json['id'],
        foto: json['foto'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        profesion: json['profesion'],
        fechaNacimiento: json['fechaNacimiento'],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "foto": foto,
        "apellido": apellido,
        "profesion": profesion,
        "fechaNacimiento": fechaNacimiento,
      };
}

int Calcular_edad(String dateTime) {
  //DateTime date = convertToDate(dateTime, "dd/MM/yyyy");
  DateTime fechaNacimiento = DateTime.parse(dateTime);

  DateTime fechaActual = new DateTime.now();
  if (fechaNacimiento.day <= fechaActual.day &&
      fechaNacimiento.month <= fechaActual.month &&
      fechaNacimiento.year <= fechaActual.year) {
    return fechaActual.year.toInt() - fechaNacimiento.year.toInt();
  } else {
    return (fechaActual.year.toInt() - fechaNacimiento.year.toInt()) - 1;
  }
}
