import 'package:assignment_11/photo.dart';
import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  PhotoDetailScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<void>(
              future: precacheImage(NetworkImage(photo.url), context),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.network(photo.url),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 25),
            Text(
              'Title: ${photo.title}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Center(
              child: Text(
                'ID: ${photo.id}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
