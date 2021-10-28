import 'package:cardgame/models/card_model.dart';

class PlayerModel {
  final String name;
  final bool isHuman;
  List<CardModel> cards;
  int score;

  PlayerModel({
    required this.name,
    this.cards = const [],
    this.isHuman = false,
    this.score = 0,
  });

  addCards(List<CardModel> newCards) {
    cards = [...cards, ...newCards];
  }

  removeCard(CardModel card) {
    cards.removeWhere((c) => c.value == card.value && c.suit == card.suit);
  }

  bool get isBot {
    return !isHuman;
  }
}
