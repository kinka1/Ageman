import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database.dart';

const String tableBaju = 'baju';

class BajuFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String diskripsi = 'diskripsi';
  static const String imageUrl = 'imageUrl';
  static const String harga = 'harga';
}

class Baju {
  final int? id;
  final String name;
  final String diskripsi;
  final String imageUrl;
  final int harga;

  Baju({
    required this.id,
    required this.name,
    required this.diskripsi,
    required this.imageUrl,
    required this.harga,
  });

  Baju copy({
    int? id,
    String? name,
    String? diskripsi,
    String? imageUrl,
    int? harga,
  }) {
    return Baju(
        id: id,
        name: name ?? this.name,
        diskripsi: diskripsi ?? this.diskripsi,
        imageUrl: imageUrl ?? this.imageUrl,
        harga: harga ?? this.harga);
  }

  static Baju fromJson(Map<String, Object?> json) {
    return Baju(
        id: json[BajuFields.id] as int?,
        name: json[BajuFields.name] as String,
        diskripsi: json[BajuFields.diskripsi] as String,
        imageUrl: json[BajuFields.imageUrl] as String,
        harga: json[BajuFields.harga] as int);
  }

  Map<String, Object?> toJson() => {
        BajuFields.id: id,
        BajuFields.name : name,
        BajuFields.diskripsi: diskripsi,
        BajuFields.imageUrl:imageUrl,
        BajuFields.harga:harga,
      };
}
