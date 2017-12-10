import "../../DollRenderer.dart";
import "CharSheet.dart";
import 'dart:async';
import "BarLayer.dart";
import 'dart:html';
import "../loader/loader.dart";

//echeladder has X text boxes for echeladder rank
//and a section for boonies earned.
//doll is on left.
/*

    write out text. 16 layers.
    ability to customize all colors in echeladder pallete.
    font color is inverse of bg color.
 */
class Echeladder extends CharSheet {

    TextLayer first;
  Echeladder(Doll doll) : super(doll) {

      first = new TextLayer("First","PLACEHOLDER",345.0,470.0, fontSize: 14, maxWidth: 100, fontName: "Courier New", emphasis: emphasis,fontColor: ReferenceColours.BLACK);

  }

  @override
  int width = 500;
  @override
  int height = 300;

  @override
  int type = 3;

  Palette paletteToReplace = new EcheladderPalette()
      ..border = '#4a92f7'
      ..first = '#8ff74a'
      ..second = '#ba1212'
      ..third = '#ffffee'
      ..fourth = '#f0ff00'
      ..fifth = '#9c00ff'
      ..six = '#2b6ade'
      ..seven = '#003614'
      ..eight = '#f8e69f'
      ..nine = '#0000ff'
      ..ten = '#eaeaea'
      ..eleven = '#ff9600'
      ..twelve = '#581212'
      ..thirteen = '#ffa6ac'
      ..fourteen = '#1f7636'
      ..fifteen = '#ffe1fc'
      ..sixteen = '#fcff00';


  Palette palette = new EcheladderPalette()
      ..border = '#444444'
      ..first = '#000000'
      ..second = '#000000'
      ..third = '#000000'
      ..fourth = '#000000'
      ..fifth = '#000000'
      ..six = '#000000'
      ..seven = '#000000'
      ..eight = '#000000'
      ..nine = '#000000'
      ..ten = '#000000'
      ..eleven = '#000000'
      ..twelve = '#000000'
      ..thirteen = '#000000'
      ..fourteen = '#000000'
      ..fifteen = '#000000'
      ..sixteen = '#000000';


  // TODO: implement barLayers
  @override
  List<BarLayer> get barLayers => [];

  // TODO: implement textLayers
  @override
  List<TextLayer> get textLayers => [first];



  void randomizePalette() {
      Random rand = new Random();
      EcheladderPalette p = new EcheladderPalette();
    for(String key in palette.names) {
        Colour newColor = new Colour(rand.nextInt(255), rand.nextInt(255),rand.nextInt(255));
        p.add(key, newColor, true);
    }
    HomestuckPalette h = doll.palette as HomestuckPalette;
    p.border = h.aspect_light;
      for(String key in p.names) {
          palette.add(key, p[key], true);
      }

  }

  @override
  Future<CanvasElement> draw() async {
      randomizePalette();
      if(canvas == null) canvas = new CanvasElement(width: width, height: height);
      CanvasElement sheetElement = await drawSheetTemplate();

      Renderer.swapPalette(sheetElement, paletteToReplace, palette);


      CanvasElement dollElement = await drawDoll(doll,200,300);
      CanvasElement textCanvas = await drawText();


      canvas.context2D.clearRect(0,0,width,height);
      canvas.context2D.drawImage(sheetElement, 300, 0);
      canvas.context2D.drawImage(textCanvas, 0, 0);
      if(!hideDoll)canvas.context2D.drawImage(dollElement,50, 100);

      return canvas;
  }
}




class EcheladderPalette extends Palette {
    static String _BORDER = "border";
    static String _FIRST = "one";
    static String _SECOND = "two";
    static String _THIRD = "three";
    static String _FOURTH = "four";
    static String _FIFTH = "five";
    static String _SIX = "six";
    static String _SEVEN = "seven";
    static String _EIGHT = "eight";
    static String _NINE = "nine";
    static String _TEN = "ten";
    static String _ELEVEN = "eleven";
    static String _TWELVE = "twelve";
    static String _THIRTEEN = "thirteen";
    static String _FOURTEEN = "fourteen";
    static String _FIFTEEN = "fifteen";
    static String _SIXTEEN = "sixteen";

    static Colour _handleInput(Object input) {
        if (input is Colour) {
            return input;
        }
        if (input is int) {
            return new Colour.fromHex(input, input
                .toRadixString(16)
                .padLeft(6, "0")
                .length > 6);
        }
        if (input is String) {
            if (input.startsWith("#")) {
                return new Colour.fromStyleString(input);
            } else {
                return new Colour.fromHexString(input);
            }
        }
        throw "Invalid AspectPalette input: colour must be a Colour object, a valid colour int, or valid hex string (with or without leading #)";
    }

    Colour get text => this[_BORDER];

    Colour get border => this[_BORDER];

    void set border(dynamic c) => this.add(_BORDER, _handleInput(c), true);

    Colour get first => this[_FIRST];

    void set first(dynamic c) => this.add(_FIRST, _handleInput(c), true);

    Colour get second => this[_SECOND];

    void set second(dynamic c) => this.add(_SECOND, _handleInput(c), true);

    Colour get third => this[_THIRD];

    void set third(dynamic c) => this.add(_THIRD, _handleInput(c), true);

    Colour get fourth => this[_FOURTH];

    void set fourth(dynamic c) => this.add(_FOURTH, _handleInput(c), true);

    Colour get fifth => this[_FIFTH];

    void set fifth(dynamic c) => this.add(_FIFTH, _handleInput(c), true);

    Colour get six => this[_SIX];

    void set six(dynamic c) => this.add(_SIX, _handleInput(c), true);

    Colour get seven => this[_SEVEN];

    void set seven(dynamic c) => this.add(_SEVEN, _handleInput(c), true);

    Colour get eight => this[_EIGHT];

    void set eight(dynamic c) => this.add(_EIGHT, _handleInput(c), true);

    Colour get nine => this[_NINE];

    void set nine(dynamic c) => this.add(_NINE, _handleInput(c), true);

    Colour get ten => this[_TEN];

    void set ten(dynamic c) => this.add(_TEN, _handleInput(c), true);

    Colour get eleven => this[_ELEVEN];

    void set eleven(dynamic c) => this.add(_ELEVEN, _handleInput(c), true);

    Colour get twelve => this[_TWELVE];

    void set twelve(dynamic c) => this.add(_TWELVE, _handleInput(c), true);

    Colour get thirteen => this[_THIRTEEN];

    void set thirteen(dynamic c) => this.add(_THIRTEEN, _handleInput(c), true);

    Colour get fourteen => this[_FOURTEEN];

    void set fourteen(dynamic c) => this.add(_FOURTEEN, _handleInput(c), true);

    Colour get fifteen => this[_FIFTEEN];

    void set fifteen(dynamic c) => this.add(_FIFTEEN, _handleInput(c), true);

    Colour get sixteen => this[_SIXTEEN];

    void set sixteen(dynamic c) => this.add(_SIXTEEN, _handleInput(c), true);


}