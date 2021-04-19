import 'dart:io';
import 'package:parcial_1/CRUD/usuario.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Usuario_DB {

  static final Usuario_DB db = Usuario_DB._();
  Database _database;
  Usuario_DB._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstanace();
    return _database;
  }

  Future<Database> getDatabaseInstanace() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'Usuario.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Usuario ('
          ' id TEXT NOT NULL PRIMARY KEY,'
          ' foto TEXT NOT NULL,'
          ' nombre TEXT NOT NULL,'
          ' apellido TEXT NOT NULL,'
          ' profesion TEXT NOT NULL,'
          ' fechaNacimiento TEXT NOT NULL'
          ')');
    });
  }
  //Consulta Total
  Future<List<Usuario>> getAllUsuario() async {
    final db = await database;
    var response = await db.rawQuery("SELECT * FROM Usuario");
    List<Usuario> list = response.map((c) => Usuario.fromJson(c)).toList();
    return list;
  }

  Future<Usuario> getUsuario(String id) async {
    final db = await database;
    var results = await db.rawQuery("SELECT * FROM Usuario WHERE id='$id'");
    if (results.isNotEmpty) {
      //print("[3]1" + Estudiante_DB.fromMap(results.first).id);
      return Usuario.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<List<Usuario>> getUsuario2(String id) async {
    final db = await database;
    var results = await db.rawQuery("SELECT * FROM Usuario WHERE id='$id'");

    List<Usuario> list;
    if (results.isNotEmpty) {
      list = results.map((c) => Usuario.fromJson(c)).toList();
      //print("[3] " +list[list.length - 1].id +" - " +list[list.length - 1].estado);
    } else {
      list = null;
      //print("[3]2 " + list.toString());
    }
    return list;
  }
  //Insert
  addUsuarioToDatabase(Usuario usuario) async {
    final db = await database;
    //var result = await db.insert('Usuario', Usuario.toMap());
    var result = await db.rawInsert(
        "INSERT INTO Usuario (id,foto,nombre,apellido,profesion,fechaNacimiento)"
        " VALUES (${usuario.id}, '${usuario.foto}', '${usuario.nombre}', "
        "'${usuario.apellido}', '${usuario.profesion}', '${usuario.fechaNacimiento}')");
    print("[id]" + usuario.id);
    return result;
  }
  //Update
  updateUsuario(Usuario usuario) async {
    final db = await database;
    //var result1 = await db.update('Usuario', Usuario.toMap());
    var result = await db.rawUpdate(
        "UPDATE Usuario SET foto = '${usuario.foto}', nombre = '${usuario.nombre}', apellido = '${usuario.apellido}',"
        " profesion = '${usuario.profesion}', fechaNacimiento = '${usuario.fechaNacimiento}'"
        " WHERE id = '${usuario.id}'");
    return result;
  }
  //Delete
  deleteUsuario(Usuario usuario) async {
    final db = await database;
    var result = await db.rawDelete("DELETE FROM Usuario"
        " WHERE id = '${usuario.id}'");
    return result;
  }
  //Delete Todos Los Registros
  deleteAll() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM Usuario');
  }

}
