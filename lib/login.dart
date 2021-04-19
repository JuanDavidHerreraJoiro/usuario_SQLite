import 'package:flutter/material.dart';
import 'package:parcial_1/CRUD/home.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

TextEditingController controladorusuario;
TextEditingController controladorpassword;

final usuario = "JUANDAVID";
final password = "JUANDAVID";
var img =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJhw_m2x5q2SR64BoxUo_kf-vtdpG_d-c_-w&usqp=CAU';
bool verpassword = true;
bool acceso = false;

class _LoginState extends State<Login> {
  void visibility() {
    setState(() {
      verpassword = !verpassword;
    });
  }

  @override
  void initState() {
    controladorusuario = TextEditingController();
    controladorpassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          Container(
            width: 1000,
            height: 1000,
            color: Colors.white,
            child: Image.network(
              'https://image.freepik.com/vector-gratis/fondo-blanco-minimo-hexagonos_79603-1453.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 150.0),
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  //height: MediaQuery.of(context).size.height,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: CircleAvatar(
                          radius: size.height * 0.10,
                          backgroundImage: NetworkImage(img),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          controller: controladorusuario,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              icon: Icon(Icons.person),
                              labelText: 'USUARIO',
                              suffix: GestureDetector(
                                child: Icon(Icons.close),
                                onTap: () {
                                  controladorusuario.clear();
                                },
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          obscureText: verpassword,
                          controller: controladorpassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              //borderSide: BorderSide(color: Colors.white),
                            ),
                            icon: Icon(Icons.lock),
                            labelText: 'PASSWORD',
                            suffixIcon: GestureDetector(
                              child: Icon(Icons.close),
                              onTap: () {
                                controladorpassword.clear();
                              },
                            ),
                            suffix: GestureDetector(
                              onTap: visibility,
                              child: Icon(verpassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: 270.0,
                            height: 50.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.blueAccent,
                              onPressed: () {
                                if (controladorusuario.text.isNotEmpty &&
                                    controladorpassword.text.isNotEmpty) {
                                  if (usuario == controladorusuario.text &&
                                      password == controladorpassword.text) {
                                    String texto1 =
                                        'USUARIO Y PASSWORD CORRECTOS';
                                    String texto2 = 'INICIAR SESION';
                                    _mensaje(
                                        context, texto1, Colors.green,texto2);
                                    acceso = true;
                                  } else {
                                    String texto1 =
                                        '¿USUARIO U/O PASSWORD INCORRECTOS?';
                                    String texto2 = 'INICIAR SESION ERROR...';
                                    _mensaje(
                                        context, texto1, Colors.red, texto2);
                                    acceso = false;
                                  }
                                } else {
                                  String texto1 =
                                      '¿USUARIO U/O PASSWORD ESTAN VACIOS?';
                                  String texto2 = 'INICIAR SESION ERROR...';
                                  _mensaje(context, texto1, Colors.red, texto2);
                                  acceso = false;
                                }
                              },
                              child: Text("LOGIN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

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
            if (acceso == true) {
              controladorpassword.clear();
              controladorusuario.clear();
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MyHome(usuario, img)));
            } else {
              Navigator.pop(context);
              controladorpassword.clear();
              controladorusuario.clear();
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
