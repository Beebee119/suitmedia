import 'package:flutter/material.dart';
import 'package:suitmedia/assets/colors.dart';
import 'package:suitmedia/pages/screen_2.dart';
import 'package:suitmedia/storage/storage.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _formNama = TextEditingController();
  final secureStorage = SecureStorage();
  String _namaLengkap;

  void initState() {
    super.initState();
    _formNama.text = 'masukkan nama';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: Key('scaffold'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          key: Key('column'),
          children: <Widget>[
            Text(
              'Masukkan nama',
              key: Key('textMasukkanNama'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Inter',
                color: Color.fromRGBO(18, 40, 75, 1.0),
              ),
            ),
            Container(
              width: 343,
              margin: EdgeInsets.fromLTRB(20, 16, 0, 0),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: gray4),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: gray4),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: gray4),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        _namaLengkap = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  await secureStorage.writeSecureData(
                      'namaLengkap', _namaLengkap);
                  print('masuk siniii 3');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EventGuest();
                  }));
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
