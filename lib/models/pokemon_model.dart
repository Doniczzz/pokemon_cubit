import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final String name;
  final String imageUrl;
  final String ability;
  final String type;
  final String height;
  final String weight;

  const Pokemon({
    required this.name,
    required this.imageUrl,
    required this.ability,
    required this.type,
    required this.height,
    required this.weight,
  });

  @override
  List<Object?> get props => [name, imageUrl, ability, type, height, weight];

  @override
  bool get stringify => true;

  get image => null;
}
