import 'package:flutter/material.dart';
import 'package:flutter_webtoon/src/pages/detail/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String thumb, title, id;

  const Webtoon({
    super.key,
    required this.thumb,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailScreen(thumb: thumb, title: title, id: id),
              fullscreenDialog: true,
            ));
      },
      child: Column(children: [
        Hero(
          tag: id,
          child: Container(
            width: 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: Image.network(thumb),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ]),
    );
  }
}
