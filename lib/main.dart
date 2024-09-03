import 'package:flutter/material.dart';

void main() => runApp(BankingApp());

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BankingHomePage(),
    );
  }
}

class BankingHomePage extends StatefulWidget {
  @override
  _BankingHomePageState createState() => _BankingHomePageState();
}

class _BankingHomePageState extends State<BankingHomePage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> _transactions = [];

  String _name = '';
  String _accountNumber = '';
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _transactions.add({
          'name': _name,
          'accountNumber': _accountNumber,
        });
      });
      // Clear form
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banking App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome do usuário'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira o nome do usuário';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Número da conta'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira o número da conta';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _accountNumber = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira a senha';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Enviar'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(_transactions[index]['name']!),
                    subtitle: Text('Conta: ${_transactions[index]['accountNumber']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
