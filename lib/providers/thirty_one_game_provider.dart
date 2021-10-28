import 'dart:math';

import 'package:cardgame/models/card_model.dart';
import 'package:cardgame/providers/game_provider.dart';

const GS_PLAYER_HAS_KNOCKED = 'GS_PLAYER_HAS_KNOCKED';

class ThirtyOneGameProvider extends GameProvider {
  @override
  Future<void> setupBoard() async {
    for (var p in players) {
      await drawCards(p, count: 3, allowAnyTime: true);
    }

    await drawCardToDiscardPile();

    turn.drawCount = 0;
  }

  @override
  bool get canEndTurn {
    return turn.drawCount == 1 && turn.actionCount == 1;
  }

  @override
  bool get canDrawCard {
    return turn.drawCount < 1;
  }

  @override
  bool canPlayCard(CardModel card) {
    return turn.drawCount == 1 && turn.actionCount < 1;
  }

  @override
  bool get gameIsOver {
    if (gameState[GS_PLAYER_HAS_KNOCKED] != null &&
        gameState[GS_PLAYER_HAS_KNOCKED] == turn.currentPlayer) {
      return true;
    }

    return false;
  }

  @override
  void finishGame() {
    for (final p in players) {
      int diamondsPoints = 0;
      int spadesPoints = 0;
      int clubsPoints = 0;
      int heartsPoints = 0;

      for (final c in p.cards) {
        int points = 0;
        switch (c.value) {
          case "KING":
          case "QUEEN":
          case "JACK":
            points += 10;
            break;
          case "ACE":
            points += 11;
            break;
          default:
            points += int.parse(c.value);
        }
        switch (c.suit) {
          case Suit.Clubs:
            clubsPoints += points;
            break;
          case Suit.Diamonds:
            diamondsPoints += points;
            break;
          case Suit.Hearts:
            heartsPoints += points;
            break;
          case Suit.Spades:
            spadesPoints += points;
            break;
        }
      }

      final totalPoints = [
        spadesPoints,
        heartsPoints,
        diamondsPoints,
        clubsPoints
      ].fold(spadesPoints, max);
      print(totalPoints);

      p.score = totalPoints;
    }

    notifyListeners();
  }

  @override
  bool get showBottomWidget => false;

  @override
  Future<void> botTurn() async {
    print("TODO: bot turn"); //TODO: update bot logic
    super.botTurn();
  }

  @override
  // TODO: implement additionalButtons
  List<ActionButton> get additionalButtons {
    return [
      ActionButton(
        label: "Knock",
        onPressed: () {
          gameState[GS_PLAYER_HAS_KNOCKED] = turn.currentPlayer;

          endTurn();
        },
      ),
    ];
  }
}
