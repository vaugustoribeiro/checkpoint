import 'package:checkpoint/apis/auth_api.dart';
import 'package:checkpoint/models/auth_model.dart';
import 'package:checkpoint/services/simple_snack_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login';

  final String company = 'a882964';
  final String origin = 'portal';
  final TextEditingController _registrationTextController =
      TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  Future login(BuildContext context) async {
    if (_registrationTextController.text == '' ||
        _passwordTextController.text == '') return;

    AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
    try {
      SimpleSnackService.busy(context, 'Entrando...');
      var authApi = AuthApi();
      await authApi.login(
        company,
        origin,
        _registrationTextController.text,
        _passwordTextController.text,
      );
      authModel.success = true;
      SimpleSnackService.clear(context);
    } catch (err) {
      authModel.success = false;
      SimpleSnackService.error(context, err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Matrícula',
              ),
              controller: _registrationTextController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              controller: _passwordTextController,
              obscureText: true,
            ),
            Container(
              height: 16,
            ),
            RaisedButton(
              color: Colors.black87,
              child: Text(
                'Entrar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => login(context),
            ),
          ],
        ),
      ),
    );
  }
}
