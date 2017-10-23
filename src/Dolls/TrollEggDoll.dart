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

class TrollEggDoll extends HomestuckTrollDoll {

    @override
    final int maxBody = 13;

    @override
    void initLayers()

    {
        SpriteLayer hairTop = new SpriteLayer("Hair","$folder/HairTop/", 1, maxHair);
        SpriteLayer hairBack = new SpriteLayer("Hair","$folder/HairBack/", 1, maxHair, <SpriteLayer>[hairTop]);
        hairTop.syncedWith.add(hairBack);
        hairBack.slave = true; //can't be selected on it's own

        SpriteLayer finLeft = new SpriteLayer("Fin","$folder/LeftFin/", 1, maxFin);
        SpriteLayer finRight = new SpriteLayer("Fin","$folder/RightFin/", 1, maxFin, <SpriteLayer>[finLeft]);
        finLeft.syncedWith.add(finRight);
        finRight.slave = true; //can't be selected on it's own

        layers.clear();
        layers.add(new SpriteLayer("Wings","$folder/Wings/", 0, maxWing));
        layers.add(hairBack);
        layers.add(finRight);
        layers.add(new SpriteLayer("Body","$folder/Egg/", 1, maxBody));
        layers.add(new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol));
        layers.add(new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth));
        layers.add(new SpriteLayer("LeftEye","$folder/LeftEye/", 1, maxEye));
        layers.add(new SpriteLayer("RightEye","$folder/RightEye/", 1, maxEye));
        layers.add(new SpriteLayer("Glasses","$folder/Glasses/", 1, maxGlass));
        layers.add(hairTop);
        layers.add(finLeft);
        layers.add(new SpriteLayer("LeftHorn","$folder/LeftHorn/", 1, maxHorn));
        layers.add(new SpriteLayer("RightHorn","$folder/RightHorn/", 1, maxHorn));
    }


}