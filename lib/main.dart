import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/Widget/custom_textfield_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD with Shared Preferences',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cnicControler = TextEditingController();
  List<Map<String, String>> _items = [];
  File? image;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

//Load items
  Future<void> _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? titles = prefs.getStringList('titles');
    List<String>? descriptions = prefs.getStringList('descriptions');
    List<String>? usercnic = prefs.getStringList('cnic');
    List<String>? imagePaths = prefs.getStringList('imagePaths');

    if (titles != null &&
        descriptions != null &&
        usercnic != null &&
        imagePaths != null) {
      setState(() {
        for (int i = 0; i < titles.length; i++) {
          _items.add({
            'title': titles[i],
            'description': descriptions[i],
            'cnic': usercnic[i],
            'imagePaths': imagePaths[i]
          });
        }
      });
    }
  }

  Future<void> _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> titles = [];
    List<String> descriptions = [];
    List<String> cnic = [];
    List<String> imagepath = [];
    for (var item in _items) {
      titles.add(item['title']!);
      descriptions.add(item['description']!);
      cnic.add(item['cnic']!);
      imagepath.add(item['imagePaths']!);
    }

    prefs.setStringList('titles', titles);
    prefs.setStringList('descriptions', descriptions);
    prefs.setStringList('cnic', cnic);
    prefs.setStringList('imagePaths', imagepath);
  }

  void _addItem(String title, String description, String cnic,
      String imagepath) {
    setState(() {
      _items.add({
        'title': title,
        'description': description,
        'cnic': cnic,
        'imagePaths': imagepath
      });
    });
    _saveItems();
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    _saveItems();
  }

  void _updateItem(int index,
      String newTitle,
      String newDescription,
      String newCnic,) {
    setState(() {
      _items[index]['title'] = newTitle;
      _items[index]['description'] = newDescription;
      _items[index]['cnic'] = newCnic;
    });
    _saveItems();
  }

  void imagePicker(ImageSource sourec) async {
    final imagepicker = ImagePicker();
    var picker = await imagepicker.pickImage(source: sourec);
    if (picker != null) {
      setState(() {
        image = File(picker.path);
      });
    }
  }

  List<int> items=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
  List storeitem=[];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.2),
        title: const Text('Todo App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              CustomField(
                controller: titleController,
                title: 'Title',
              ),
              const SizedBox(
                height: 16,
              ),
              CustomField(
                controller: descriptionController,
                title: 'Description',
                minLine: 3,
                maxline: 5,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomField(
                controller: cnicControler,
                title: 'CNIC',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16,
              ),


              Text('size'),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing:2,
                    crossAxisSpacing: 2

                  ),
                  itemBuilder: (context, index) =>
                      InkWell(
                        onTap: (){
                          if(storeitem.contains(items[index])){
                            storeitem.add(items[index]);
                          }else{
                            storeitem.removeAt(items[index]);
                          }

                          setState(() {

                          });
                          print(storeitem);
                        },
                        child: Container(
                          height: 50,
                          width: 70,
                          decoration: BoxDecoration(color:items==index? Colors.amber:Colors.green,),child: Text(items[index].toString()),),
                      )),)
,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green.withOpacity(0.2),
                          child: IconButton(
                            onPressed: () {
                              imagePicker(ImageSource.gallery);
                            },
                            icon: const Icon(
                              Icons.image,
                              size: 24,
                            ),
                          )),
                      Text('Gallery')
                    ],
                  ),
                  Column(
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.green.withOpacity(0.2),
                            child: IconButton(
                              onPressed: () {
                                imagePicker(ImageSource.camera);
                              },
                              icon: const Icon(
                                Icons.camera,
                                size: 24,
                              ),
                            )),
                        Text('Camera')
                      ])
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 100,
                  width: 100,
                  child: image != null
                      ? Image.file(File(image!.path))
                      : Icon(Icons.image)),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    _addItem(titleController.text, descriptionController.text,
                        cnicControler.text, image!.path);
                  },
                  child: const Text('Saved Data')),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    if (_items.isEmpty) {
                      return const Text('data is empty');
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Dismissible(
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          _removeItem(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading:
                            Image.file(File(_items[index]['imagePaths']!)),
                            title: Text(
                              _items[index]['title']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_items[index]['description']!),
                                Text(_items[index]['cnic']!),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  final titleController = TextEditingController(
                                      text: _items[index]['title']);
                                  final descriptionController =
                                  TextEditingController(
                                      text: _items[index]['description']);
                                  final _cnicControler = TextEditingController(
                                      text: _items[index]['cnic']);
                                  return AlertDialog(
                                    title: const Text('Edit Item'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomField(
                                          controller: titleController,
                                          title: 'title',
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        CustomField(
                                          controller: descriptionController,
                                          title: 'description',
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        CustomField(
                                          controller: _cnicControler,
                                          title: 'CNIC',
                                          keyboardType: TextInputType.number,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _updateItem(
                                              index,
                                              titleController.text,
                                              descriptionController.text,
                                              _cnicControler.text);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
