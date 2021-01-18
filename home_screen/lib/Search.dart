import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';


// To parse this JSON data, do
//
//     final plants = plantsFromJson(jsonString);


//'https://trefle.io/api/v1/plants?token=Hmdu-XqTVw-cQNvGp-qLuZpckmgvR7FjLLzFLmmu9Iw&filter[common_name]=jerusalem%20artichoke'

String url = 'https://trefle.io/api/v1/plants?token=Hmdu-XqTVw-cQNvGp-qLuZpckmgvR7FjLLzFLmmu9Iw';
//my test url from the trefle api which asks for all plants

Future<Datum> getPlant() async{
  final response = await http.get('$url');
  print(response);
  return plantsFromJson(response.body);
} //The getPlant() method will call the API endpoint which is defined in url.
//  A JSON string in response.body will be received,
//  this has to be sent to plantsFromJson so that it can parse the JSON data


class plantSearch extends StatelessWidget {//'plantSearch screen'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //sets an Appbar at the top of the screen
        title: Text('plantSearch'), //places a title in the Appbar
        backgroundColor: Colors.green,),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.adb),//just a random icon to press
              onPressed: () async => getPlant(),//calls the function getPlant()
            ),
          ],
        ),
      ),
    );
  }
}

Datum plantsFromJson(String str) => Datum.fromJson(json.decode(str));

String plantsToJson(Datum data) => json.encode(data.toJson());



class Datum {
  Datum({
    this.id,
    this.commonName,
    this.slug,
    this.scientificName,
    this.year,
    this.bibliography,
    this.author,
    this.status,
    this.rank,
    this.familyCommonName,
    this.genusId,
    this.imageUrl,
    this.synonyms,
    this.genus,
    this.family,
    this.links,
  });

  int id;
  String commonName;
  String slug;
  String scientificName;
  int year;
  String bibliography;
  String author;
  String status;
  String rank;
  String familyCommonName;
  int genusId;
  String imageUrl;
  List<String> synonyms;
  String genus;
  String family;
  DatumLinks links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    commonName: json["common_name"],
    slug: json["slug"],
    scientificName: json["scientific_name"],
    year: json["year"],
    bibliography: json["bibliography"],
    author: json["author"],
    status: json["status"],
    rank: json["rank"],
    familyCommonName: json["family_common_name"],
    genusId: json["genus_id"],
    imageUrl: json["image_url"],
    synonyms: List<String>.from(json["synonyms"].map((x) => x)),
    genus: json["genus"],
    family: json["family"],
    links: DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "common_name": commonName,
    "slug": slug,
    "scientific_name": scientificName,
    "year": year,
    "bibliography": bibliography,
    "author": author,
    "status": status,
    "rank": rank,
    "family_common_name": familyCommonName,
    "genus_id": genusId,
    "image_url": imageUrl,
    "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
    "genus": genus,
    "family": family,
    "links": links.toJson(),
  };
}

class DatumLinks {
  DatumLinks({
    this.self,
    this.plant,
    this.genus,
  });

  String self;
  String plant;
  String genus;

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    self: json["self"],
    plant: json["plant"],
    genus: json["genus"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "plant": plant,
    "genus": genus,
  };
}

class InstructionLinks {
  InstructionLinks({
    this.self,
    this.first,
    this.last,
  });

  String self;
  String first;
  String last;

  factory InstructionLinks.fromJson(Map<String, dynamic> json) => InstructionLinks(
    self: json["self"],
    first: json["first"],
    last: json["last"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "first": first,
    "last": last,
  };
}

class Meta {
  Meta({
    this.total,
  });

  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
  };
}