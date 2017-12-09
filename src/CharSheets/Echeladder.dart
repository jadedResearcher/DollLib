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
    TODO: why is color replacement not working?
    write out text.
    ability to customize all colors in echeladder pallete.
 */
class Echeladder extends CharSheet {
  Echeladder(Doll doll) : super(doll);

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
      ..fifth = '#9c00ff';


  Palette palette = new EcheladderPalette()
      ..border = '#444444'
      ..first = '#000000'
      ..second = '#000000'
      ..third = '#000000'
      ..fourth = '#000000'
      ..fifth = '#000000';


  // TODO: implement barLayers
  @override
  List<BarLayer> get barLayers => [];

  // TODO: implement textLayers
  @override
  List<TextLayer> get textLayers => [];

  Future<CanvasElement>  drawDoll(Doll doll) async {
      CanvasElement monsterElement = new CanvasElement(width:200, height: 200);
      if(hideDoll) return monsterElement;
      CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
      await Renderer.drawDoll(dollCanvas, doll);
      //Renderer.drawBG(monsterElement, ReferenceColours.RED, ReferenceColours.WHITE);

      dollCanvas = Renderer.cropToVisible(dollCanvas);

      Renderer.drawToFitCentered(monsterElement, dollCanvas);
      return monsterElement;
  }

  @override
  Future<CanvasElement> draw() async {
      if(canvas == null) canvas = new CanvasElement(width: width, height: height);
      CanvasElement sheetElement = await drawSheetTemplate();

      Renderer.swapPalette(sheetElement, paletteToReplace, palette);


      CanvasElement dollElement = await drawDoll(doll);
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
    static String _FIRST = "first";
    static String _SECOND = "second";
    static String _THIRD = "third";
    static String _FOURTH = "fourth";
    static String _FIFTH = "fifth";

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


}