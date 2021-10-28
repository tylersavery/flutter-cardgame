import 'package:cardgame/components/playing_card.dart';
import 'package:cardgame/constants.dart';
import 'package:cardgame/models/card_model.dart';
import 'package:cardgame/models/player_model.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final double size;
  final PlayerModel player;
  final Function(CardModel)? onPlayCard;

  const CardList({
    Key? key,
    required this.player,
    this.size = 1,
    this.onPlayCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CARD_HEIGHT * size,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: player.cards.length,
        itemBuilder: (context, index) {
          final card = player.cards[index];
          return PlayingCard(
            card: card,
            size: size,
            // visible: player.isHuman,
            visible: true,
            onPlayCard: onPlayCard,
          );
        },
      ),
    );
  }
}
