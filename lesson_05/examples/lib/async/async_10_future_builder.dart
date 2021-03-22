import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(FutureBuilderDemo());
}

class DemoWidget10 extends StatefulWidget {
  @override
  _DemoWidgetState createState() => _DemoWidgetState();
}

class _DemoWidgetState extends State<DemoWidget10> {

  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      appBar: AppBar(
        title: Text('FutureBuilderDemo!'),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder<Image>(
            future: _fetchNetworkData(),
            builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString(), textAlign: TextAlign.center);
              } else {
                return Text('Ждем выполнения асинхронной операции', textAlign: TextAlign.center);
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<Image> _fetchNetworkData() {
  final http = MyOwnHttpImplementor();
  return http.get(Uri.parse('http://some-image-from-network.com'));
}

class FutureBuilderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FutureBuilderDemo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText2: TextStyle(fontSize: 25, color: Colors.blue),
          )),
      home: DemoWidget10(),
    );
  }
}

class MyOwnHttpImplementor {
  Future<Image> get(Uri uri) {
    final completer = Completer<Image>();

    Future.delayed(Duration(seconds: 10), () {
      completer.complete(Image.asset('assets/gifs/so_fast_cats.gif'));
      //completer.completeError(HttpException('Uri is not accessible'));
    });

    return completer.future;
  }
}
