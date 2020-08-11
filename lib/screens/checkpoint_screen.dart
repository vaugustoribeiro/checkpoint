import 'package:checkpoint/apis/justification_api.dart';
import 'package:checkpoint/services/simple_snack_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:checkpoint/models/time_sheet_model.dart';

class CheckpointScreen extends StatelessWidget {
  static const String route = '/checkpoint';

  Widget build(BuildContext context) {
    var provider = Provider.of<TimeSheetModel>(context);

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
              validity: DateTime(provider.selectedDay.year,
                  provider.selectedDay.month, provider.selectedDay.day, 9),
            ),
            RegisterButton(
              message: 'Inicio almoço',
              readonly: true,
              validity: DateTime(provider.selectedDay.year,
                  provider.selectedDay.month, provider.selectedDay.day, 12),
            ),
            RegisterButton(
              message: 'Fim almoço',
              readonly: true,
              validity: DateTime(provider.selectedDay.year,
                  provider.selectedDay.month, provider.selectedDay.day, 13),
            ),
            RegisterButton(
              message: 'Fim expediente',
              readonly: true,
              validity: DateTime(provider.selectedDay.year,
                  provider.selectedDay.month, provider.selectedDay.day, 18),
            ),
            RegisterButton(
              message: '',
              readonly: false,
              validity: DateTime.now(),
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
  final DateTime validity;

  RegisterButton(
      {@required this.validity, String message = '', this.readonly = false}) {
    _txtMessageController.text = message;
  }

  Future registerCheckPoint(
    BuildContext context,
    DateTime validity,
  ) async {
    try {
      SimpleSnackService.busy(context, 'Registrando...');
      await _justificationApi.post(validity, _txtMessageController.text);

      var provider = Provider.of<TimeSheetModel>(context, listen: false);
      await provider.changeValidity(validity);

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
                floatingLabelBehavior: FloatingLabelBehavior.never,
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
                  currentTime: validity,
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
