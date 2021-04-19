import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parcial_1/CRUD/home.dart';
import 'package:parcial_1/CRUD/usuario.dart';
import 'package:parcial_1/service/future_post.dart';

class Registrar_Usuario extends StatefulWidget {
  final titulo;
  Registrar_Usuario(this.titulo);

  @override
  _Registrar_UsuarioState createState() => _Registrar_UsuarioState();
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

class _Registrar_UsuarioState extends State<Registrar_Usuario> {
  List<Usuario> _usuarioadd = [];

  @override
  void initState() {
    controladorid = TextEditingController();
    controladornombre = TextEditingController();
    controladorapellido = TextEditingController();
    controladorfoto = TextEditingController();
    controladorprofesion = TextEditingController();
    controladorfechaNacimiento = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                Text(widget.titulo, style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  width: 10,
                ),
                Text("GUARDAR USUARIO", style: TextStyle(fontSize: 18.0)),
              ])
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

                          _twoButtonAlterDialog(context, _usuarioadd);
                        } else {
                          String texto1 = '!ERROR HAY CAMPOS VACIOS¡';
                          String texto2 = 'REGISTRAR USUARIO ERROR...';
                          _mensaje(context, texto1, Colors.red, texto2, "SI");
                        }
                      },
                      child: Text("REGISTRAR",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                          )),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("CANCELAR",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                    )
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

enum ConfirmAction { CANCELAR, CONFIRMAR }

Future<ConfirmAction> _twoButtonAlterDialog(
    BuildContext context, List<Usuario> _usuariosadd) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("GUARDAR USUARIO"),
        content: Text("¿Esta Seguro de registrar a: " +
            controladornombre.text +
            " " +
            controladorapellido.text +
            " ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              GuardarUsuario(_usuariosadd.first);
              Navigator.of(context).pop(ConfirmAction.CONFIRMAR);
              Navigator.pop(context, _usuariosadd);
            },
            child:
                const Text("CONFIRMAR", style: TextStyle(color: Colors.green)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCELAR);
              //Navigator.pop(context);
            },
            child: const Text("CANCELAR", style: TextStyle(color: Colors.grey)),
          )
        ],
      );
    },
  );
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
              controladorfechaNacimiento.clear();
              vacio = "NO";
              Navigator.pop(context);
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
