import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();
  }

  List<File> editedImage = [];
  Future<void> loadImage() async {
    List<File> loadImage = await getHistory();
    setState(() {
      editedImage = loadImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: loadImage, icon: Icon(Icons.restore_rounded))
        ],
      ),
      body: ListView.builder(
          itemCount: editedImage.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(editedImage[index].path.split('/').last),
                onTap: () {
                  showDialog(

                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return SimpleDialog(

                          children: [
                            Image(
                              width: 250,
                                height: 250,
                                image:
                                Image.file(File(editedImage[index].path),).image),
                          ]
                        );
                      });

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPreview(image: editedImage[index].path)));
                },
              ),
            );
          }),
    );
  }

  Future<List<File>> getHistory() async {
    List<File> editedImage = [];
    Directory? directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = directory.listSync(recursive: true);
    for (FileSystemEntity file in files) {
      if (file is File && file.path.endsWith('.jpg')) {
        editedImage.add(file);
      }
    }
    return editedImage;
  }

}
