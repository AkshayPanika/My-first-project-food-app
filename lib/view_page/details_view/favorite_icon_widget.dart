import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/favorite_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final int index;
  const FavoriteIconWidget({super.key, required this.index});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(builder: (context, value, child) {
      return IconButton(
        onPressed: (){
          value.toggleFavoriteItem(widget.index);
        },
        icon:Icon(
          value.selectedFavoriteItem.contains(widget.index)?
          Icons.favorite:
          Icons.favorite_border,size:32,color: Colors.red,),
      );
    },);
  }
}
