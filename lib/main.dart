import 'package:flutter/material.dart';

void main() {
  runApp(const IMCApp());
}

class IMC {
  double peso;
  double altura;

  IMC({required this.peso, required this.altura});

  double calcularIMC() {
    return peso / (altura * altura);
  }

  String classificarIMC(double imc) {
    if (imc < 16) {
      return "Magreza grave";
    } else if (imc < 17) {
      return "Magreza moderada";
    } else if (imc < 18.5) {
      return "Magreza leve";
    } else if (imc < 25) {
      return "Saudável";
    } else if (imc < 30) {
      return "Sobrepeso";
    } else if (imc < 35) {
      return "Obesidade Grau I";
    } else if (imc < 40) {
      return "Obesidade Grau II (Severa)";
    } else {
      return "Obesidade Grau III (Mórbida)";
    }
  }
}

class IMCApp extends StatelessWidget {
  const IMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("IMC - Calculadora"),
        ),
        body: const IMCForm(),
      ),
    );
  }
}

class IMCForm extends StatefulWidget {
  const IMCForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IMCFormState createState() => _IMCFormState();
}

class _IMCFormState extends State<IMCForm> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  List<String> resultados = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: pesoController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Peso (kg)"),
          ),
          TextField(
            controller: alturaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Altura (m)"),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              double peso = double.tryParse(pesoController.text) ?? 0.0;
              double altura = double.tryParse(alturaController.text) ?? 0.0;

              IMC imc = IMC(peso: peso, altura: altura);
              double resultadoIMC = imc.calcularIMC();
              String classificacao = imc.classificarIMC(resultadoIMC);
              setState(() {
                resultados.add(
                    "Seu IMC é: $resultadoIMC \n\nClassificação: $classificacao");
              });
            },
            child: const Text("Calcular"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: resultados.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(resultados[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
