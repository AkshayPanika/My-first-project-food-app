
import 'package:flutter/cupertino.dart';

class FavoriteProvider with ChangeNotifier{
  final List<int> _selectedFavoriteItem = [];
  List<int> get selectedFavoriteItem => _selectedFavoriteItem;




  void deleteForFavoritePage(int index) {
    _selectedFavoriteItem.removeAt(index);
    notifyListeners();
  }

  void toggleFavoriteItem(int value){
    final isFavorite = _selectedFavoriteItem.contains(value);
   if(isFavorite){
     _selectedFavoriteItem.remove(value);
   }
   else{
     _selectedFavoriteItem.add(value);
   }
    notifyListeners();
  }







/*

  bool isFavorite(int value){
    final isFavorite = _selectedFavorite.contains(value);
    return isFavorite;
  }

  void clearFavorite(){
    _selectedFavorite =[];
    notifyListeners();
  }
*/

}