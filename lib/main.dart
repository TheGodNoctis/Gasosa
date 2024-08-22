import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue[900],
          secondary: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.blueGrey[900],
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _alcoolController = TextEditingController();
  final TextEditingController _gasolinaController = TextEditingController();
  String _resultado = "";

  void _calcular() {
    String alcoolText = _alcoolController.text;
    String gasolinaText = _gasolinaController.text;

    if (alcoolText.isEmpty || gasolinaText.isEmpty) {
      _showAlertDialog("Erro", "Por favor, preencha ambos os campos.");
      return;
    }

    double? alcool = double.tryParse(alcoolText);
    double? gasolina = double.tryParse(gasolinaText);

    if (alcool == null || gasolina == null) {
      _showAlertDialog("Erro", "Por favor, insira valores numéricos válidos.");
      return;
    }

    double razao = alcool / gasolina;
    String razaoFormatada = razao.toStringAsFixed(2);

    setState(() {
      if (razao < 0.7) {
        _resultado = "Razão: $razaoFormatada. Abasteça com Álcool!";
      } else {
        _resultado = "Razão: $razaoFormatada. Abasteça com Gasolina!";
      }
    });
  }

  void _limparCampos() {
    _alcoolController.clear();
    _gasolinaController.clear();
    setState(() {
      _resultado = "";
    });
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[800],
          title: Text(title, style: TextStyle(color: Colors.white)),
          content: Text(message, style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              child: Text("OK", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Álcool ou Gasolina?'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.local_gas_station,
              size: 120.0,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: _alcoolController,
              label: "Preço do Álcool (R\$)",
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: _gasolinaController,
              label: "Preço da Gasolina (R\$)",
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calcular,
                    child: Text("Calcular"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700], // Botão "Calcular" azul escuro
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _limparCampos,
                    child: Text("Limpar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Botão "Limpar" preto
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: _resultado.contains("Álcool") ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 18.0),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.blueGrey[800],
      ),
    );
  }
}

