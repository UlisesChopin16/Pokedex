// To parse this JSON data, do
//
//     final getDataModelPokemons = getDataModelPokemonsFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

GetDataModelPokemons getDataModelPokemonsFromJson(String str) => GetDataModelPokemons.fromJson(json.decode(str));

String getDataModelPokemonsToJson(GetDataModelPokemons data) => json.encode(data.toJson());

class GetDataModelPokemons {
    List<Result> results;

    GetDataModelPokemons({
        required this.results,
    });

    factory GetDataModelPokemons.fromJson(Map<String, dynamic> json) => GetDataModelPokemons(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    int pokId;
    String pokNum;
    String pokNom;
    String pokImg;
    String pokImgL;
    String pokImgA;
    String pokTipo;
    String pokAltura;
    String pokPeso;

    Result({
        required this.pokId,
        required this.pokNum,
        required this.pokNom,
        required this.pokImg,
        required this.pokImgL,
        required this.pokImgA,
        required this.pokTipo,
        required this.pokAltura,
        required this.pokPeso,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        pokId: json["pok_id"],
        pokNum: json["pok_num"],
        pokNom: json["pok_nom"],
        pokImg: json["pok_img"],
        pokImgL: json["pok_imgL"],
        pokImgA: json["pok_imgA"],
        pokTipo: json["pok_tipo"],
        pokAltura: json["pok_altura"],
        pokPeso: json["pok_peso"],
    );

    Map<String, dynamic> toJson() => {
        "pok_id": pokId,
        "pok_num": pokNum,
        "pok_nom": pokNom,
        "pok_img": pokImg,
        "pok_imgL": pokImgL,
        "pok_imgA": pokImgA,
        "pok_tipo": pokTipo,
        "pok_altura": pokAltura,
        "pok_peso": pokPeso,
    };
}
