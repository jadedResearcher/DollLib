import "HomestuckTrollDoll.dart";
import "../Misc/random.dart";
import "../includes/colour.dart";
import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../includes/bytebuilder.dart";
import "../includes/palette.dart";
import "../Dolls/HomestuckDoll.dart";
import "../Rendering/ReferenceColors.dart";

class EggDoll extends HomestuckDoll {

    @override
    final int maxBody = 13;

    @override
    void initLayers()

    {
        SpriteLayer hairTop = new SpriteLayer("Hair","$folder/HairTop/", 1, maxHair);
        SpriteLayer hairBack = new SpriteLayer("Hair","$folder/HairBack/", 1, maxHair, <SpriteLayer>[hairTop]);
        hairTop.syncedWith.add(hairBack);
        hairBack.slave = true; //can't be selected on it's own


        layers.clear();
        layers.add(hairBack);
        layers.add(new SpriteLayer("Body","$folder/Egg/", 1, maxBody));
        layers.add(new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol));
        layers.add(new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth));
        layers.add(new SpriteLayer("LeftEye","$folder/LeftEye/", 1, maxEye));
        layers.add(new SpriteLayer("RightEye","$folder/RightEye/", 1, maxEye));
        layers.add(new SpriteLayer("Glasses","$folder/Glasses/", 1, maxGlass));
        layers.add(hairTop);
    }


}