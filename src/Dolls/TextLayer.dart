import "../includes/colour.dart";

/*

A text layer is like a sprite layer, but with text instead of images.

It ALSO always has a x/y start location.
 */

class TextLayer {

    String text;
    double topLeftX;
    double topLeftY;
    int maxWidth;
    int fontSize;
    String emphasis = "";
    //ctx.fillStyle = "#000000";
    Colour fontColor;
    //ctx.font = "42px Times New Roman";
    String fontName;

    TextLayer(String this.text, double this.topLeftX, double this.topLeftY, {this.emphasis: "", this.maxWidth: 100, this.fontSize: 12, this.fontColor: null, this.fontName: "Times New Roman"}) {
        if(fontColor == null) {
            fontColor = new Colour(0,0,0);
        }
    }

    String get font => "$emphasis ${fontSize}px $fontName";
    String get fillStyle => fontColor.toStyleString();


}