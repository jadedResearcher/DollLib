
import "../../DollRenderer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../includes/bytebuilder.dart";

abstract class NamedLayerDoll extends Doll {
    List<String> possibleParts = new List<String>();
    List<NamedSpriteLayer> layers = new List<NamedSpriteLayer>();

    void addLayerNamed(String name) {
        layers.add(new NamedSpriteLayer(possibleParts,name,"$folder/Parts/", 0, 0));
    }

    //i am assuming type was already read at this point. Type, Exo is required.
    @override
    void initFromReader(ByteReader reader, Palette newP, [bool layersNeedInit = true]) {
        initLayers(); //gets body/crown.
        int numFeatures = reader.readExpGolomb();
        print("I think there are ${numFeatures} features");
        int featuresRead = 2; //for exo and doll type

        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name in names) {
            featuresRead +=1;
            Colour newColor = new Colour(reader.readByte(),reader.readByte(),reader.readByte());
            newP.add(name, newColor, true);
        }

        for(String name in newP.names) {
            print("loading color $name");
            palette.add(name, newP[name], true);
        }

        for(int i = 1; i< (numFeatures-featuresRead); i++) {
            int imgNumber = reader.readByte();
            print("reading layer feature $i ,its $imgNumber");

            addLayerNamed(possibleParts[imgNumber]);
        }

    }

    String toDataBytesX([ByteBuilder builder = null]) {
        if(builder == null) builder = new ByteBuilder();
        int length = dataOrderLayers.length + palette.names.length + 1;//one byte for doll type
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
            int number = possibleParts.indexOf(l.name);
            if(number>=0) {
                print("adding${l.name}/ ${number} to data string builder.");
                builder.appendByte(number);
            }
        }

        return BASE64URL.encode(builder.toBuffer().asUint8List());
    }
    

}