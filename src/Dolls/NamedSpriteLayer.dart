import 'dart:math';
import "SpriteLayer.dart";


class NamedSpriteLayer extends SpriteLayer {
    //because it extends can't NOT have a number, but it won't use it.
  NamedSpriteLayer(String name, String imgNameBase, int imgNumber, int maxImageNumber) : super(name, imgNameBase, imgNumber, maxImageNumber);

  //major difference from named layer to regular
  String get imgLocation {
      return "$imgNameBase${name}.${imgFormat}";
  }

}