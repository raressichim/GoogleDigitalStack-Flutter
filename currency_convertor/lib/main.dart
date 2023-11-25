import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Converter(),
    );
  }
}

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  TextEditingController controller = TextEditingController();
  bool hasError = false;
  double amount = 0.0;
  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Convertor'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Image.network(
                'https://www.agerpres.ro/foto/watermark/6676435?author=GABRIEL+PETRESCU+%2FFOTO+AGERPRES'),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              //controller: controller,
              decoration: InputDecoration(
                  hintText: 'Enter Euros Amount',
                  errorText: hasError ? 'Please enter a valid number' : null),
              onChanged: (value) {
                setState(() {
                  hasError = false;
                  if (value.isEmpty) {
                    amount = 0.0;
                  } else {
                    try {
                      amount = double.parse(value);
                    } catch (e) {
                      hasError = true;
                    }
                  }
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (amount > 0) {
                    setState(() {
                      result = amount * 4.97;
                      hasError = false;
                    });
                  }
                },
                child: const Text('Convert to Ron')),
            Text('${result.toStringAsFixed(2)} Ron', style: const TextStyle(fontSize: 30))
          ],
        )));
  }
}
