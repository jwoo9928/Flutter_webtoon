import 'package:flutter/material.dart';
import 'package:flutter_webtoon/src/models/webtoon_detail_model.dart';
import 'package:flutter_webtoon/src/models/webtoon_episode_model.dart';
import 'package:flutter_webtoon/src/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String thumb, title, id;
  const DetailScreen({
    super.key,
    required this.thumb,
    required this.title,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  initState() {
    super.initState();
    webtoon = ApiService().getToonsById(widget.id);
    episodes = ApiService().getLatestEpisodeById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontSize: 24)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
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
                  child: Image.network(widget.thumb),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          FutureBuilder(
            future: webtoon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${snapshot.data!.genre} / ${snapshot.data!.age}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          FutureBuilder(
              future: episodes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!
                        .map<Widget>((e) => ListTile(
                              title: Text(e.title),
                              subtitle: Text(e.date),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ))
                        .toList(),
                  );
                }
                return const CircularProgressIndicator();
              })
        ]),
      ),
    );
  }
}
