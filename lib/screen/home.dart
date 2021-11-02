import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tugasmod3_kel17/screen/profiles.dart';
import 'package:tugasmod3_kel17/screens/detail.dart';
import 'package:tugasmod3_kel17/screens/profile.dart';
import 'package:tugasmod3_kel17/screens/profiles.dart';

import 'detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<AiringModel>> airing;
  late Future<List<Top>> top;

  @override
  void initState() {
    super.initState();
    airing = fetchAiring();
    top = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.search,
                    size: 24,
                  ),
                  Text(
                    'KELOMPOK 17',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 15),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profiles(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.account_box_rounded,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: 180.0,
                child: FutureBuilder<List<AiringModel>>(
                    future: airing,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    item: snapshot.data![index].malId,
                                    title: snapshot.data![index].title,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.green[400],
                              shadowColor: Colors.green[200],
                              elevation: 0,
                              child: Container(
                                height: 150,
                                width: 100,
                                child: Column(
                                  children: [
                                    Container(
                                        height: 150,
                                        child: Image.network(
                                            snapshot.data![index].image)),
                                    Text(
                                      snapshot.data![index].title,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 10),
              child: Text(
                'TOP ANIME',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black, letterSpacing: .5, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SizedBox(
                // height: 200.0,
                child: FutureBuilder<List<Top>>(
                    future: top,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              ListTile(
                            leading: Image.network(
                              snapshot.data![index].imageUrl,
                            ),
                            title: Text(snapshot.data![index].title),
                            subtitle:
                                Text(snapshot.data![index].score.toString()),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    title: snapshot.data![index].title,
                                    item: snapshot.data![index].malId,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AiringModel {
  final int malId;
  final String title;
  final num rating;
  final String image;

  AiringModel({
    required this.rating,
    required this.title,
    required this.image,
    required this.malId,
  });

  factory AiringModel.fromJson(Map<String, dynamic> json) {
    return AiringModel(
      malId: json['mal_id'],
      title: json['title'],
      rating: json["score"],
      image: json['image_url'],
    );
  }
}

//fetch api

Future<List<AiringModel>> fetchAiring() async {
  String api = 'https://api.jikan.moe/v3/top/anime/1/airing';
  final response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    var airingJson = jsonDecode(response.body)['top'] as List;

    return airingJson.map((airing) => AiringModel.fromJson(airing)).toList();

    //jika tidak di mapping hanya mendapat instance
    //intance of keynya
  } else {
    throw Exception('Failed to load airing');
  }
}

class Top {
  final int malId;
  final String title;
  final String imageUrl;
  final double score;

  Top({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  factory Top.fromJson(Map<String, dynamic> json) {
    return Top(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
}

// function untuk fetch api
Future<List<Top>> fetchShows() async {
  String api = 'https://api.jikan.moe/v3/top/anime/1';
  final response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;

    return topShowsJson.map((top) => Top.fromJson(top)).toList();

    //jika tidak di mapping hanya mendapat instance
    //intance of keynya
  } else {
    throw Exception('Failed to load shows');
  }
}
