import 'package:equatable/equatable.dart';

class BackgroundModel extends Equatable {
  const BackgroundModel(
      {required this.isImage,
      required this.isColor,
      required this.isCustom,
      required this.src});

  final bool isImage;
  final bool isColor;
  final bool isCustom;
  final String src;

  static const List<String> images = [
    'https://images.pexels.com/photos/1028225/pexels-photo-1028225.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/298821/pexels-photo-298821.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1624504/pexels-photo-1624504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1161375/pexels-photo-1161375.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/2088172/pexels-photo-2088172.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1731041/pexels-photo-1731041.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/691031/pexels-photo-691031.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1105189/pexels-photo-1105189.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1336924/pexels-photo-1336924.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/822528/pexels-photo-822528.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1366921/pexels-photo-1366921.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/2087517/pexels-photo-2087517.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/172067/pexels-photo-172067.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1444619/pexels-photo-1444619.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
  ];

  factory BackgroundModel.isColor(String sre) {
    return BackgroundModel(
        isImage: false, isColor: true, isCustom: false, src: sre);
  }
  factory BackgroundModel.isImage(String sre) {
    return BackgroundModel(
        isImage: true, isColor: false, isCustom: false, src: sre);
  }
  factory BackgroundModel.defoult() {
    return BackgroundModel(
        isImage: true, isColor: false, isCustom: false, src: images.first);
  }

  BackgroundModel copyWith(
      {bool? isImage, bool? isColor, bool? isCustom, String? src}) {
    return BackgroundModel(
        isImage: isImage ?? this.isImage,
        isColor: isColor ?? this.isColor,
        isCustom: isCustom ?? this.isCustom,
        src: src ?? this.src);
  }

  @override
  List<Object?> get props => [isImage, isColor, isCustom, src];

  factory BackgroundModel.fromMap(Map<String, dynamic> map) {
    return BackgroundModel(
      isImage: map['isImage'] as bool,
      isColor: map['isColor'] as bool,
      isCustom: map['isCustom'] as bool,
      src: map['src'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'isImage': isImage,
        'isColor': isColor,
        'isCustom': isCustom,
        'src': src,
      };
}
