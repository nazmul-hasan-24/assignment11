import 'dart:convert';

import 'package:assignment_11/photo.dart';
import 'package:assignment_11/photo_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({super.key});

  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        final List<dynamic> parsedData = json.decode(response.body);
        setState(() {
          photos = parsedData.map((json) => Photo.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load photo. Check network connection');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery App'),
      ),
      body: photos.isNotEmpty
          ? ListView.separated(
              itemCount: photos.length,
              separatorBuilder: (context, index) =>
                  const Divider(), // Add a Divider between items
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(photos[index].title),
                  leading: Image.network(photos[index].thumbnailUrl),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhotoDetailScreen(photo: photos[index]),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
