import "../Misc/random.dart";
import "../includes/colour.dart";
import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../includes/bytebuilder.dart";
import "../includes/palette.dart";
import "HomestuckDoll.dart";
import 'HomestuckTrollDoll.dart';
import "ConsortDoll.dart";
import "DenizenDoll.dart";
import "../Rendering/ReferenceColors.dart";
abstract class Doll {
    String folder;
    Colour _associatedColor;
    int width = 400;
    int height = 300;
    int renderingType = 0;
    ///in rendering order.
    List<SpriteLayer> layers = new List<SpriteLayer>();
    Palette palette;

    Palette paletteSource = ReferenceColours.SPRITE_PALETTE;

    Colour get associatedColor {
        if(_associatedColor == null) {
            if(palette is HomestuckPalette || palette is HomestuckTrollPalette) {
                _associatedColor = (palette as HomestuckPalette).aspect_light;
            }else {
                _associatedColor = palette.first;
            }
        }
        return _associatedColor;
    }

    void initLayers();
    void randomize() {
        randomizeColors();
        randomizeNotColors();
    }

    void randomizeColors() {
        Random rand = new Random();
        List<String> names = new List<String>.from(palette.names);
        for(String name in names) {
            palette.add(name, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        }
    }

    void randomizeNotColors() {
        Random rand = new Random();
        int firstEye = -100;
        for(SpriteLayer l in layers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber+1);
            //keep eyes synced unless player decides otherwise
            if(firstEye > 0 && l.imgNameBase.contains("Eye")) l.imgNumber = firstEye;
            if(firstEye < 0 && l.imgNameBase.contains("Eye")) firstEye = l.imgNumber;
            if(l.imgNumber == 0) l.imgNumber = 1;
            if(l.imgNameBase.contains("Glasses") && rand.nextDouble() > 0.35) l.imgNumber = 0;
        }
    }

    //i am assuming type was already read at this point. Type, Exo is required.
    void initFromReader(ByteReader reader, Palette newP) {
        initLayers();
        int numFeatures = reader.readExpGolomb();
        print("I think there are ${numFeatures} features");
        int bytesRead = 0;

        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name in names) {
            bytesRead +=3;
            Colour newColor = new Colour(reader.readByte(),reader.readByte(),reader.readByte());
            newP.add(name, newColor, true);
        }

        for(String name in newP.names) {
            print("loading color $name");
            palette.add(name, newP[name], true);
        }

        //layer is last so can add new layers.
        for(SpriteLayer l in layers) {
            print("loading layer ${l.name}");
            //older strings with less layers
            if(bytesRead < numFeatures) l.imgNumber = reader.readByte();
            bytesRead += 1;

        }
    }

    String toDataBytesX([ByteBuilder builder = null]) {
        if(builder == null) builder = new ByteBuilder();
        int length = layers.length + palette.names.length + 1;//one byte for doll type
        builder.appendByte(renderingType); //value of 1 means homestuck doll
        builder.appendExpGolomb(length); //for length


        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name in names) {
            Colour color = palette[name];
            builder.appendByte(color.red);
            builder.appendByte(color.green);
            builder.appendByte(color.blue);
        }

        //layer is last so can add new layers
        for(SpriteLayer l in layers) {
            //print("adding ${l.imgNameBase} to data string builder.");
            builder.appendByte(l.imgNumber);
        }

        return BASE64URL.encode(builder.toBuffer().asUint8List());
    }

    //if it's in url form, it has a ? right before the text.
    static String removeURLFromString(String ds) {
        List<String> ret = ds.split("?");
        if(ret.length == 1) return ret[0];
        return ret[1];
    }


    /* first part of any data string tells me what type of doll to load.*/
    static Doll loadSpecificDoll(String ds) {
        String dataString = removeURLFromString(ds);
        print("dataString is $dataString");
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte();
        print("type is $type");

        if(type == new HomestuckDoll().renderingType) {
            return new HomestuckDoll.fromReader(reader);
        }

        if(type == new HomestuckTrollDoll().renderingType) {
            return new HomestuckTrollDoll.fromReader(reader);
        }

        if(type == new ConsortDoll().renderingType) {
            return new ConsortDoll.fromReader(reader);
        }

        if(type == new DenizenDoll().renderingType) {
            return new DenizenDoll.fromReader(reader);
        }
    }

    static Doll makeRandomDoll()  {
        Random rand = new Random();
        Doll doll;
        double randNum = rand.nextDouble();

        if(randNum > 0.75) {
            print('kid doll');
            doll = new HomestuckDoll();
        }else if (randNum > 0.5) {
            print("troll doll");
            doll = new HomestuckTrollDoll();
        } else if (randNum > 0.25) {
            print("consort doll");
            doll = new ConsortDoll();
        }else {
            print("denizen doll");
            doll = new DenizenDoll();
        }
        //doll = new HomestuckTrollDoll(); //hardcoded for testing
        return doll;
    }


}