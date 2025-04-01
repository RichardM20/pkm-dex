import 'package:flutter/material.dart';
import 'package:poke_api/src/models/pokemon_move_table.dart';
import 'package:poke_api/src/views/details/tabbar/poke_moves/widgets/table/widgets/poke_table_cell.dart';

class MoveTableRow extends TableRow {
  final PokemonMove move;
  final bool isHeader;
  final Color? headerColor;
  final ValueChanged<String>? onMovePressed;

  MoveTableRow({
    required this.move,
    this.isHeader = false,
    this.headerColor,
    this.onMovePressed,
  }) : super(
         decoration: isHeader ? BoxDecoration(color: headerColor) : null,
         children: [
           MoveTableCell(
             text: move.name,
             isTitle: isHeader,
             url: move.url,
             onPressed:
                 move.url != null && onMovePressed != null
                     ? () => onMovePressed(move.url!)
                     : null,
           ),
           MoveTableCell(
             text: move.method,
             isTitle: isHeader,
             url: move.url,
             onPressed:
                 move.url != null && onMovePressed != null
                     ? () => onMovePressed(move.url!)
                     : null,
           ),
           MoveTableCell(
             text: move.displayLevel,
             isTitle: isHeader,
             url: move.url,
             onPressed:
                 move.url != null && onMovePressed != null
                     ? () => onMovePressed(move.url!)
                     : null,
           ),
         ],
       );
}
