// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'dart:io'; // needed for sleep

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Async tests',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const MyHomePage(title: 'Async Tests'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? lastFound;
  bool wasStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("last found: $lastFound"),
            ElevatedButton(
              onPressed: wasStarted ? null : startCalculation,
              child: const Text("Start calculation"),
            ),
          ],
        ),
      ),
    );
  }

  void startCalculation() async {
    setState(() {
      wasStarted = true;
    });

    // var countFound1 = performCalculation();
    // countFount1 = 5;

    int countFound = await performCalculation();
    print("found $countFound prime numbers");
    setState(() {
      wasStarted = false;
    });
  }

  Future<int> performCalculation() async {
    var countFound = 0;
    for (int i = 5; i < 5000; i += 2) {
      if (isPrime(i)) {
        print("found prime $i");
        setState(() {
          lastFound = i;
        });
        countFound++;
        await Future.delayed(const Duration(milliseconds: 1));
        // next line would be a synchronous wait (not available in Chrome)
        //sleep(const Duration(milliseconds: 1));
      }
    }
    return countFound;
  }

  bool isPrime(int test) {
    for (int i = 3; i < test / 2; i += 2) {
      if (test % i == 0) {
        return false;
      }
    }
    return true;
  }
}
