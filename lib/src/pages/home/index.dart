import 'package:flutter/material.dart';
import 'package:flutter_webtoon/src/models/webtoon_model.dart';
import 'package:flutter_webtoon/src/services/api_service.dart';
import 'package:flutter_webtoon/src/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService().getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Today`s Naver Toons',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 1,
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
            thumb: webtoon.thumb, title: webtoon.title, id: webtoon.id);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
