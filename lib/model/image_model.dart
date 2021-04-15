// To parse this JSON data, do
//
//     final imageDataModel = imageDataModelFromJson(jsonString);

import 'dart:convert';

ImageDataModel imageDataModelFromJson(String str) => ImageDataModel.fromJson(json.decode(str));

String imageDataModelToJson(ImageDataModel data) => json.encode(data.toJson());

class ImageDataModel {
  ImageDataModel({
    this.status,
    this.images,
  });

  String status;
  List<ImageData> images;

  factory ImageDataModel.fromJson(Map<String, dynamic> json) => ImageDataModel(
    status: json["status"],
    images: List<ImageData>.from(json["images"].map((x) => ImageData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class ImageData {
  ImageData({
    this.xtImage,
    this.id,
  });

  String xtImage;
  String id;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    xtImage: json["xt_image"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "xt_image": xtImage,
    "id": id,
  };
}
