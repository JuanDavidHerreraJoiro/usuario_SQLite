import 'package:flutter/cupertino.dart';
import 'package:parcial_1/CRUD/usuario.dart';
import 'package:parcial_1/Providers/Usuario_db.dart';

Future<List<Usuario>> ConsultarUsuario_Total() async {
  List<Usuario> listaUsuario = await Usuario_DB.db.getAllUsuario();
  if (listaUsuario == null) {
    return null;
  } else {
    return listaUsuario;
  }
}

Future<List<Usuario>> ConsultarUsuario(String id) async {
  List<Usuario> listaUsuario = await Usuario_DB.db.getUsuario2(id);

  if (listaUsuario == null) {
    return null;
  } else {
    return listaUsuario;
  }
}

void GuardarUsuario(Usuario usuario) {
  FutureBuilder(
    future: Usuario_DB.db.addUsuarioToDatabase(usuario),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      print("[id]" + snapshot.data);
      return snapshot.data;
      
    },
  );
}

void ActualizarUsuario(Usuario usuario) {
  FutureBuilder(
    future: Usuario_DB.db.updateUsuario(usuario),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return snapshot.data;
    },
  );
}

void EliminarUsuario(Usuario Usuario) {
  FutureBuilder(
    future: Usuario_DB.db.deleteUsuario(Usuario),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return snapshot.data;
    },
  );
}

void EliminarTodo() {
  FutureBuilder(
    future: Usuario_DB.db.deleteAll(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return snapshot.data;
    },
  );
}

