import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pam_mo_zad3/model/game_session.dart';

import '../model/maze_room.dart';

class MazeRoomFullScreenWidget extends StatelessWidget {
  final MazeRoom room;
  final GameSession? gameSession;

  final String gridTemplate = """
  .         upperDoor .
  leftDoor  center    rightDoor
  .         lowerDoor .
  """;

  const MazeRoomFullScreenWidget(
      {super.key, required this.room, this.gameSession});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: LayoutGrid(
          areas: gridTemplate,
          gridFit: GridFit.expand,
          columnGap: 20,
          rowGap: 20,
          columnSizes: [1.fr, 3.fr, 1.fr],
          rowSizes: [1.fr, 3.fr, 1.fr],
          children: [
            _buildDoor(
                    room.hasUpperDoor
                        ? () => gameSession?.moveThroughTopDoor()
                        : null,
                    Icons.keyboard_arrow_up)
                .inGridArea("upperDoor"),
            _buildDoor(
                    room.hasRightDoor
                        ? () => gameSession?.moveThroughRightDoor()
                        : null,
                    Icons.keyboard_arrow_right)
                .inGridArea("rightDoor"),
            _buildDoor(
                    room.hasLowerDoor
                        ? () => gameSession?.moveThroughBottomDoor()
                        : null,
                    Icons.keyboard_arrow_down)
                .inGridArea("lowerDoor"),
            _buildDoor(
                    room.hasLeftDoor
                        ? () => gameSession?.moveThroughLeftDoor()
                        : null,
                    Icons.keyboard_arrow_left)
                .inGridArea("leftDoor"),
            _buildCenter().inGridArea("center")
          ],
        ));
  }

  Widget _buildDoor(void Function()? cb, IconData icon) {
    return ElevatedButton(
      onPressed: cb,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, double.infinity)),
      child: Icon(icon, size: 100),
    );
  }

  Widget _buildCenter() {
    return Center(
      child: Text(
        '(${room.location.x}, ${room.location.y})',
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}
