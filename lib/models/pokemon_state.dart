import 'package:equatable/equatable.dart';
import 'package:pokemon_cubit/models/pokemon_model.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;

  const PokemonLoaded(this.pokemons);

  @override
  List<Object?> get props => [pokemons];
}

class PokemonError extends PokemonState {
  final String errorMessage;

  const PokemonError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PokemonDetailsLoaded extends PokemonState {
  final Pokemon pokemon;

  const PokemonDetailsLoaded(this.pokemon);

  @override
  List<Object?> get props => [pokemon];
}
