import 'package:checkpoint/apis/justification_api.dart';
import 'package:checkpoint/services/simple_snack_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CheckpointScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Checkpoint'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RegisterButton(
              message: 'Inicio expediente',
              readonly: true,
            ),
            RegisterButton(
              message: 'Inicio almoço',
              readonly: true,
            ),
            RegisterButton(
              message: 'Fim almoço',
              readonly: true,
            ),
            RegisterButton(
              message: 'Fim expediente',
              readonly: true,
            ),
            RegisterButton(
              message: '',
              readonly: false,
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final JustificationApi _justificationApi = JustificationApi();
  final TextEditingController _txtMessageController = TextEditingController();
  final bool readonly;

  RegisterButton({String message = '', this.readonly = false}) {
    _txtMessageController.text = message;
  }

  Future registerCheckPoint(
    BuildContext context,
    DateTime validity,
  ) async {
    try {
      SimpleSnackService.busy(context, 'Registrando...');
      await _justificationApi.post(validity, _txtMessageController.text);
      SimpleSnackService.success(context, 'Registro realizado com sucesso!');
    } catch (err) {
      SimpleSnackService.error(context, 'Deu ruim!');
    } finally {
      if (!readonly) {
        _txtMessageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(4, 4, 0, 4),
      margin: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              readOnly: readonly,
              controller: _txtMessageController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Customizado',
                hasFloatingPlaceholder: false,
                isDense: true,
              ),
            ),
          ),
          Container(
            // margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: RaisedButton(
              color: Colors.black87,
              child: Text(
                'Registrar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                DatePicker.showDateTimePicker(
                  context,
                  locale: LocaleType.pt,
                  currentTime: DateTime.now(),
                  onConfirm: (DateTime dt) {
                    registerCheckPoint(context, dt);
                  },
                );
              },
              // padding: EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }
}
