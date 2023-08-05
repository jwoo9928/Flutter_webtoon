import 'dart:convert';

import 'package:flutter_webtoon/src/models/webtoon_detail_model.dart';
import 'package:flutter_webtoon/src/models/webtoon_episode_model.dart';
import 'package:flutter_webtoon/src/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = 'today';

  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final Uri url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Exception('Failed to load data');
  }

  Future<WebtoonDetailModel> getToonsById(String id) async {
    final Uri url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Exception('Failed to load data');
  }

  Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(String id) async {
    List<WebtoonEpisodeModel> webtoonInstances = [];
    final Uri url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        webtoonInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return webtoonInstances;
    }
    throw Exception('Failed to load data');
  }
}
