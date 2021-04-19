import 'dart:io';
import "package:flutter/material.dart";
import 'package:parcial_1/CRUD/actualizar_cliente.dart';
import 'package:parcial_1/CRUD/registrar_usuario.dart';
import 'package:parcial_1/CRUD/usuario.dart';
import 'package:parcial_1/login.dart';
import 'package:parcial_1/service/future_post.dart';

class MyHome extends StatefulWidget {
  final titulo;
  final img;
  MyHome(this.titulo, this.img);

  @override
  _MyHomeState createState() => _MyHomeState();
}

int cant;
bool exception_imagen = false;

class _MyHomeState extends State<MyHome> {
  /*List<Usuario> _usuarios = [
    Usuario(
        id: "1",
        foto:
            "https://w7.pngwing.com/pngs/807/47/png-transparent-x-log-x-plane-logo-aircraft-roblox-x-mark-transport-bird-silhouette-thumbnail.png",
        nombre: "Juan David",
        apellido: "Herrera Joiro",
        profesion: "ING Sistemas",
        fechaNacimiento: "2000-07-19"),
    Usuario(
        id: "2",
        foto:
            "https://sites.google.com/site/imagenesdecarrosgratis/_/rsrc/1421516636272/home/carros-deportivos-lamborghini-aventador-tron_aventador.jpg",
        nombre: "Maria Luisa",
        apellido: "Perez Rojas",
        profesion: "ING Electronica",
        fechaNacimiento: "1999-04-28"),
    Usuario(
        id: "3",
        foto:
            "https://sites.google.com/site/imagenesdecarrosgratis/_/rsrc/1421516636272/home/carros-deportivos-lamborghini-aventador-tron_aventador.jpg",
        nombre: "Oscar David",
        apellido: "Perdomo Romero",
        profesion: "ING Sistemas",
        fechaNacimiento: "1997-11-13"),
    Usuario(
        id: "4",
        foto:
            "https://sites.google.com/site/imagenesdecarrosgratis/_/rsrc/1421516636272/home/carros-deportivos-lamborghini-aventador-tron_aventador.jpg",
        nombre: "Juliana Lorena",
        apellido: "Ruiz Perez",
        profesion: "Enfermeria",
        fechaNacimiento: "1992-02-18"),
    Usuario(
        id: "5",
        foto:
            "https://sites.google.com/site/imagenesdecarrosgratis/_/rsrc/1421516636272/home/carros-deportivos-lamborghini-aventador-tron_aventador.jpg",
        nombre: "Cristian",
        apellido: "Joiro",
        profesion: "Medicina",
        fechaNacimiento: "2021-02-18"),
    Usuario(
        id: "6",
        foto: "https://image.flaticon.com/icons/png/512/44/44948.png",
        nombre: "Angelica Cristiana",
        apellido: "Ochoa Romero",
        profesion: "Medicina",
        fechaNacimiento: "2020-03-21")
  ];
*/
  @override
  Widget build(BuildContext context) {
    //GlobalKey<RefreshIndicatorState>();
/*
    setState(() {
      for (var i = 0; i < _usuarios.length; i++) {
        if (_usuarios.length != 0 || _usuarios != null) {
          consulta(_usuarios[i]);
        }
      }
    });
*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Icon(
                  Icons.person_sharp,
                  size: 50,
                ),
              ),
              Text(widget.titulo, style: TextStyle(fontSize: 22.0)),
              SizedBox(
                width: 50.0,
              ),
              Text("HOME", style: TextStyle(fontSize: 22.0)),
            ]),
      ),
      body: FutureBuilder(
        future: ConsultarUsuario_Total(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot1) {
          return ListView.builder(
            itemCount: snapshot1.data == null ? 0 : snapshot1.data.length,
            itemBuilder: (context, index) {
              print(snapshot1.data[index].id + "[]" + index.toString());
              return FutureBuilder(
                future: ConsultarUsuario_Total(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Usuario>> snapshot) {
                  if (snapshot.data != null) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          _modificarcliente(snapshot.data[index]);
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          _eliminarusuario(context, snapshot.data[index]);
                        });
                      },
                      title: Text(
                          snapshot.data[index].nombre +
                              " " +
                              snapshot.data[index].apellido,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          )),
                      subtitle: Text(snapshot.data[index].profesion),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            _errorFoto(snapshot.data[index])
                                .toString()), //exepcion
                      ),
                      trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(snapshot.data[index].fechaNacimiento,
                                style: TextStyle(
                                  color: Colors.green,
                                )),
                            Text(
                                Calcular_edad(
                                        snapshot.data[index].fechaNacimiento)
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                          ]),
                    );
                  }
                  return CircularProgressIndicator();
                },
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: "BOTON1",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Registrar_Usuario(widget.titulo),
                ),
              ).then((resultado) {
                setState(() {
                  //_usuarios.addAll(resultado);
                });
              });
            },
            tooltip: "ADICIONAR USUARIOS",
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: "BOTON2",
            onPressed: () {
              String texto1 = '¿DESEA CERRAR LA SESION?';
              String texto2 = 'CERRAR SESION';
              _mensaje(context, texto1, Colors.blueGrey, texto2);
            }, //=> exit(0),
            tooltip: "EXIT",
            child: Icon(Icons.exit_to_app_sharp),
          ),
        ],
      ),
    );
  }

  _errorFoto(Usuario user) {
    try {
      exception_imagen = false;
    } catch (e) {
      exception_imagen = true;
    } finally {
      if (exception_imagen == false) {
        return user.foto;
      } else {
        return "https://image.flaticon.com/icons/png/512/44/44948.png";
      }
    }
  }

  _modificarcliente(Usuario user) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('ACTUALIZAR USUARIO'),
        content: Text('¿Esta Seguro de actualizar a ' +
            user.nombre +
            ' ' +
            user.apellido +
            '?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Actualizar_Usuario(
                      user.foto,
                      user.nombre,
                      user.apellido,
                      user.profesion,
                      user.fechaNacimiento,
                      widget.titulo,
                      user.id),
                ),
              ).then((resultado) {
                //_usuarios.addAll(resultado);
                Navigator.pop(context);
                setState(() {});
              });
              //this._usuarios.remove(user);
            },
            child: Text(
              'ACTUALIZAR',
              style: TextStyle(color: Colors.orange),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCELAR',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  _eliminarusuario(context, Usuario user) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('ELIMINAR USUARIO'),
        content: Text('¿Esta Seguro de Eliminar a: ' +
            user.nombre +
            " " +
            user.apellido +
            '?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                //this._usuarios.remove(user);
                EliminarUsuario(user);
                Navigator.pop(context);
              });
            },
            child: Text(
              'ELIMINAR',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCELAR',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class Int {}

_mensaje(context, texto1, Color colors, texto2) {
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
            exit(0);
          },
          child: Text(
            'CONFIRMAR',
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'CANCELAR',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

List<Usuario> listUsuario = new List<Usuario>();

consulta(Usuario usuario) async {
  //EliminarTodo();/*
  listUsuario.clear();
  listUsuario = await ConsultarUsuario(usuario.id);

  if (listUsuario == null) {
    GuardarUsuario(usuario);
  } //*/
}

List<Usuario> indexidadList;

indexidad(List<Usuario> _usuarios) async {
  indexidadList = await ConsultarUsuario_Total();
  print("[CT] " + indexidadList.length.toString());
  if (indexidadList.length >= _usuarios.length) {
    cant = indexidadList.length;
  } else if (indexidadList == null || indexidadList.length == 0) {
    cant = _usuarios.length;
  } else {
    cant = 0;
  }
  return cant;
}
