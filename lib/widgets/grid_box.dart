import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/utils/constants.dart';
import 'package:xno_game_ui/widgets/custom_text.dart';

class GridBox extends StatelessWidget {
  const GridBox({
    super.key,
    required this.absorbingPoint,
    required this.tappedFunction,
  });

  final bool absorbingPoint;
  final Function tappedFunction;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 400,
        maxWidth: 400,
      ),
      child: AbsorbPointer(
        absorbing: absorbingPoint,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => tappedFunction(index, roomDataProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: roomDataProvider.displayElements[index] == ''
                        ? white
                        : roomDataProvider.displayElements[index] == 'O'
                            ? playerColor
                                .elementAt(roomDataProvider.player2.color)
                            : playerColor
                                .elementAt(roomDataProvider.player1.color),
                  ),
                ),
                child: Center(
                  child: CustomText(
                    text: roomDataProvider.displayElements[index],
                    fontSize: size.width < 600 ? 50 : 100,
                    color: roomDataProvider.displayElements[index] == 'O'
                        ? playerColor.elementAt(roomDataProvider.player2.color)
                        : playerColor.elementAt(roomDataProvider.player1.color),
                    shadows: [
                      Shadow(
                        blurRadius: 40,
                        color: roomDataProvider.displayElements[index] == 'O'
                            ? playerColor
                                .elementAt(roomDataProvider.player2.color)
                            : playerColor
                                .elementAt(roomDataProvider.player1.color),
                      ),
                    ],
                  )
                      .animate(
                        onPlay: (controller) => controller.loop(),
                      )
                      .shake(duration: 700.ms)
                      .shimmer(duration: 1000.ms)
                      .then(delay: 2000.ms),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
