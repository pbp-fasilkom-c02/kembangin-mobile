// To parse this JSON data, do
//
//     final rekomendasi = rekomendasiFromJson(jsonString);

import 'dart:convert';

List<Rekomendasi> rekomendasiFromJson(String str) => List<Rekomendasi>.from(json.decode(str).map((x) => Rekomendasi.fromJson(x)));

String rekomendasiToJson(List<Rekomendasi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rekomendasi {
    Rekomendasi({
        required this.model,
        required this.pk,
        required this.fields,
    });

    Model? model;
    int pk;
    Fields fields;

    factory Rekomendasi.fromJson(Map<String, dynamic> json) => Rekomendasi(
        model: modelValues.map[json["model"]],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse![model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        this.user,
        required this.gambar,
        required this.namaBarang,
        required this.hargaBarang,
        required this.deskripsi,
        required this.url,
    });

    dynamic user;
    String gambar;
    String namaBarang;
    String hargaBarang;
    String deskripsi;
    String url;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        gambar: json["gambar"],
        namaBarang: json["nama_barang"],
        hargaBarang: json["harga_barang"],
        deskripsi: json["deskripsi"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "gambar": gambar,
        "nama_barang": namaBarang,
        "harga_barang": hargaBarang,
        "deskripsi": deskripsi,
        "url": url,
    };
}

enum Model { REKOMENDASI_REKOMENDASI }

final modelValues =
    EnumValues({"rekomendasi.rekomendasi": Model.REKOMENDASI_REKOMENDASI});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}