import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Beer tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _miss = [0,0,0,0,0,0,0,0,0,0,0,0];
  List<int> _hit = [0,0,0,0,0,0,0,0,0,0,0,0];

  @override
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    load();
  }

  void _resetCounters() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _miss = [0,0,0,0,0,0,0,0,0,0,0,0];
      _hit = [0,0,0,0,0,0,0,0,0,0,0,0];
      save();
    });
  }

  void load() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? missString = prefs.getStringList('missString');
    if (missString != null) {
      _miss = missString!.map((i) => int.parse(i)).toList();
    }
    final List<String>? hitString = prefs.getStringList('hitString');
    if (hitString != null) {
      _hit = hitString!.map((i) => int.parse(i)).toList();
    }
    setState(() {});
  }

  void save() async {
    List<String> missString = _miss.map((i) => i.toString()).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("missString", missString);
    List<String> hitString = _hit.map((i) => i.toString()).toList();
    prefs.setStringList("hitString", hitString);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '10 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[0]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[0]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[0]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[0]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '09 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[1]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[1]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[1]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[1]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '08 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[2]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[2]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[2]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[2]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '07 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[3]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[3]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[3]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[3]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '06 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[4]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[4]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[4]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[4]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '05 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[5]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[5]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[5]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[5]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '04 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[6]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[6]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[6]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[6]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '03 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[7]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[7]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[7]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[7]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '02 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[8]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[8]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[8]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[8]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '01 cups:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_miss[9]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red,),
                  tooltip: 'Miss the cup',
                  onPressed: () {
                    setState(() {
                      _miss[9]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green,),
                  tooltip: 'Hit the cup',
                  onPressed: () {
                    setState(() {
                      _hit[9]++;
                      save();
                    });
                  },
                ),
                Text(
                  '\t',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '${_hit[9]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetCounters,
        tooltip: 'Delete all stored data permanently',
        child: const Icon(Icons.delete_forever),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
