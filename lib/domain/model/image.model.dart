import 'package:json_annotation/json_annotation.dart';

part 'image.model.g.dart';

@JsonSerializable()
class ImageModel {
  
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  ImageModel({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl
  });

  factory ImageModel.fromJson(Map<String, dynamic> jsn) => _$ImageFromJson(jsn);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
  
}