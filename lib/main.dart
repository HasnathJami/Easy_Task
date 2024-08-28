import 'package:easy_task/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');

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

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Add Note'),
        content: SingleChildScrollView(
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('Cancel')),
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('Add')),
        ],
      );
    });
  }

}
