import 'dart:math';
import "../includes/bytebuilder.dart";
import 'dart:convert';
import "dart:typed_data";


typedef void JROnClick();

//one byte of data
class SpriteLayer {
    int numbytes = 1; //hardcoded to be 1 for this layer type
    String imgFormat;
    String imgNameBase;
    String name;
    int _imgNumber;
    int maxImageNumber;
    String description = "";
    //slaves just match whatever another thingy tells them to do.
    bool slave = false;
    List<SpriteLayer> syncedWith; //for things like hair where they should always match.

    bool changed = true; //generate descriptions when created, that will set it to false

    SpriteLayer(this.name, this.imgNameBase, this._imgNumber, this.maxImageNumber, [this.syncedWith = null, this.imgFormat = "png"]) {
        if(syncedWith == null) syncedWith = new List<SpriteLayer>();
    }

    String get imgLocation {
        return "$imgNameBase${imgNumber}.${imgFormat}";
    }

    void saveToBuilder(ByteBuilder builder) {
        if(numbytes == 1) {
            builder.appendByte(imgNumber);
        }else {
            //should first write the exo, then the numberm
            throw("not yet supported");
        }
    }

    void loadFromReader(ByteReader reader) {
        if(numbytes == 1) {
            imgNumber = reader.readByte();
        }else {
            //todo should first read the exo, then the number
            throw("not yet supported");
        }
    }



    int get imgNumber {
        return _imgNumber;
    }

    //so i know to update the description
    void set imgNumber(int i) {
        _imgNumber = i;
        changed = true;
        //things like hair top/back
        for(SpriteLayer l in syncedWith) {
            if(l.imgNumber != i) l.imgNumber = i; //no infinite loops, dunkass
        }
    }

}

class ClickableSpriteLayer extends SpriteLayer {
    //I need to know where i am in the canvas
    double topLeftX;
    double topLeftY;
    double width;
    double height;
    JROnClick jrOnClick;

    ClickableSpriteLayer(String name, String imgNameBase, int imgNumber,int maxImageNumber, this.topLeftX, this.topLeftY, this.width, this.height,  [List<SpriteLayer> syncedWith = null,String format = "png"]): super(name, imgNameBase, imgNumber,maxImageNumber,syncedWith,format) {
        jrOnClick = incrementNumber;
    }

    bool wasClicked(double x, double y) {
        print("Does ($x,$y) mean $imgNameBase was clicked?");
        Rectangle rect = new Rectangle(topLeftX, topLeftY, width, height);
        print("Rect is $rect");
        return rect.containsPoint(new Point(x,y));
    }

    void incrementNumber() {
        imgNumber ++;
        if(imgNumber > maxImageNumber) imgNumber = 0;
        print("incrementing $imgNameBase to $imgNumber");
    }
}