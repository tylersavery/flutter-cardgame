import 'package:cached_network_image/cached_network_image.dart';
import 'package:cardgame/components/card_back.dart';
import 'package:cardgame/constants.dart';
import 'package:cardgame/models/card_model.dart';
import 'package:flutter/material.dart';

class PlayingCard extends StatelessWidget {
  final CardModel card;
  final double size;
  final bool visible;
  final Function(CardModel)? onPlayCard;

  const PlayingCard(
      {Key? key,
      required this.card,
      this.size = 1,
      this.visible = false,
      this.onPlayCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPlayCard != null) onPlayCard!(card);
      },
      child: Container(
        width: CARD_WIDTH * size,
        height: CARD_HEIGHT * size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: visible
            ? CachedNetworkImage(
                imageUrl: card.image,
                width: CARD_WIDTH * size,
                height: CARD_HEIGHT * size,
              )
            : CardBack(size: size),
      ),
    );
  }
}
