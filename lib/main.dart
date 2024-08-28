import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  runApp(MaterialApp(
    title: 'Easy Task',
    theme: ThemeData(primarySwatch: Colors.green),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Easy Keep"),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: Hive.openBox('jami'),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(snapshot.data!.get('name').toString()),
                      subtitle: Text(snapshot.data!.get('details').toString()),
                      trailing: IconButton(
                        onPressed: () {
                          // snapshot.data!.put('name','edited name');
                          snapshot.data!.delete('name');
                          setState(() {});
                        },
                        icon: Icon(Icons.delete),
                      ),
                    )
                  ],
                );
              }),
          // FutureBuilder(
          //     future: Hive.openBox('jami2'),
          //     builder: (context, snapshot) {
          //       return Column(
          //         children: [
          //           ListTile(
          //             title: Text(snapshot.data!.get('name2').toString()),
          //           )
          //         ],
          //       );
          //     }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('jami');
          box.put('name', 'j c');
          box.put('details', {'age': '00', 'gender': 'male'});
          print(box.get('name'));
          print(box.get('details'));
          print(box.get('details')['gender']);

          // var box2 = await Hive.openBox('jami2');
          // box2.put('name2', 'name 2');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
