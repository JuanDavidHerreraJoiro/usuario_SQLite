import 'package:flutter/material.dart';
import 'package:parcial_1/CRUD/home.dart';
import 'package:parcial_1/CRUD/usuario.dart';
import 'package:parcial_1/service/future_post.dart';

class Actualizar_Usuario extends StatefulWidget {
  final id;
  final foto;
  final nombre;
  final apellido;
  final profesion;
  final fechaNacimiento;
  final titulo;
  Actualizar_Usuario(this.foto, this.nombre, this.apellido, this.profesion,
      this.fechaNacimiento, this.titulo, this.id);

  @override
  _Actualizar_UsuarioState createState() => _Actualizar_UsuarioState();
}

String val = "NO";
String vacio = "NO";
DateTime selectedDate = DateTime.now();
TextEditingController controladorid;
TextEditingController controladornombre;
TextEditingController controladorapellido;
TextEditingController controladorfoto;
TextEditingController controladorprofesion;
TextEditingController controladorfechaNacimiento;

class _Actualizar_UsuarioState extends State<Actualizar_Usuario> {
  List<Usuario> _usuarioadd = [];

  @override
  void initState() {
    controladorid = TextEditingController(text: this.widget.id);
    controladornombre = TextEditingController(text: this.widget.nombre);
    controladorapellido = TextEditingController(text: this.widget.apellido);
    controladorfoto = TextEditingController(text: this.widget.foto);
    controladorprofesion = TextEditingController(text: this.widget.profesion);
    controladorfechaNacimiento =
        TextEditingController(text: this.widget.fechaNacimiento);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          automaticallyImplyLeading: false,
          title: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(widget.titulo, style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  width: 40.0,
                ),
                Text("ACTUALIZAR USUARIO", style: TextStyle(fontSize: 18.0)),
              ])
          //Text("GUARDAR USUARIO"),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  //SingleChildScrollView
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: controladorid,
                    decoration: InputDecoration(
                        labelText: 'ID',
                        suffix: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            controladorid.clear();
                          },
                        )),
                  ),
                ),
                Padding(
                  //SingleChildScrollView
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: controladorfoto,
                    decoration: InputDecoration(
                        labelText: 'FOTO',
                        suffix: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            controladorfoto.clear();
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    controller: controladornombre,
                    decoration: InputDecoration(
                        labelText: 'NOMBRE',
                        suffix: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            controladornombre.clear();
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    controller: controladorapellido,
                    decoration: InputDecoration(
                        labelText: 'APELLIDOS',
                        suffix: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            controladorapellido.clear();
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    controller:
                        controladorprofesion, // Probar todos los teclados
                    decoration: InputDecoration(
                        labelText: 'PROFESION',
                        suffix: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            controladorprofesion.clear();
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    controller: controladorfechaNacimiento,
                    decoration: InputDecoration(
                      labelText: 'FECHA DE NACIMIENTO',
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.date_range_outlined,
                          size: 50,
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      suffix: GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () {
                          controladorfechaNacimiento.clear();
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        if (controladorid.text.trim().isNotEmpty &&
                            controladornombre.text.trim().isNotEmpty &&
                            controladorapellido.text.trim().isNotEmpty &&
                            controladorfoto.text.trim().isNotEmpty &&
                            controladorprofesion.text.trim().isNotEmpty &&
                            controladorfechaNacimiento.text.trim().isNotEmpty) {
                          _usuarioadd.add(Usuario(
                              id: controladorid.text.trim(),
                              foto: controladorfoto.text.trim(),
                              nombre: controladornombre.text.trim(),
                              apellido: controladorapellido.text.trim(),
                              profesion: controladorprofesion.text.trim(),
                              fechaNacimiento:
                                  controladorfechaNacimiento.text.trim()));

                          ActualizarUsuario(Usuario(
                              id: controladorid.text.trim(),
                              foto: controladorfoto.text.trim(),
                              nombre: controladornombre.text.trim(),
                              apellido: controladorapellido.text.trim(),
                              profesion: controladorprofesion.text.trim(),
                              fechaNacimiento:
                                  controladorfechaNacimiento.text.trim()));

                          Navigator.pop(context, _usuarioadd);
                        } else {
                          String texto1 = '!ERROR HAY CAMPOS VACIOS¡';
                          String texto2 = 'ACTUALIZAR USUARIO ERROR...';
                          _mensaje(context, texto1, Colors.red, texto2, "SI");
                        }
                      },
                      child: Text("ACTUALIZAR",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 18,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime fechaActual = new DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1000),
      lastDate: DateTime(3030),
      helpText: "SELECCIONAR FECHA",
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        if (selectedDate.day > fechaActual.day &&
            selectedDate.month >= fechaActual.month &&
            selectedDate.year >= fechaActual.year) {
          String texto1 = '!LA FECHA ES MAYOR A LA ACTUAL¡';
          String texto2 = 'FECHA ERROR...';
          _mensaje(context, texto1, Colors.red, texto2, "NO");
        } else {
          controladorfechaNacimiento.text =
              "${selectedDate.toLocal()}".split(' ')[0];
        }
      });
  }
}

_mensaje(context, texto1, Color colors, texto2, vacio) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(texto2, style: TextStyle(color: Colors.white)),
      backgroundColor: colors,
      content: Text('' + texto1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          )),
      actions: [
        TextButton(
          onPressed: () {
            if (vacio == "SI") {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              controladorfechaNacimiento.clear();
            }
          },
          child: Text(
            'CONFIRMAR',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
