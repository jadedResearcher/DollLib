import "../../DollRenderer.dart";
import "CharSheet.dart";
import 'dart:async';
import 'dart:html';
/*
Based on the char sheet by Sylveon on discord
TODO: find out how they want to be credited.

 */

class SylveonSheet extends CharSheet {

    @override
    int width = 1000;
    @override

    int height = 825;

    @override
    int type = 1;

    String name;
    TextLayer nameLayer;

  @override
  List<TextLayer> get textLayers => <TextLayer>[nameLayer];

  SylveonSheet(Doll doll):super(doll) {
        name = nameForDoll();
        nameLayer = new TextLayer("Name",name,35.0,28.0, fontSize: 18);

  }

    Future<CanvasElement>  drawDoll(Doll doll) async {
        CanvasElement monsterElement = new CanvasElement(width: (256).round(), height: (208).round());
        CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
        await Renderer.drawDoll(dollCanvas, doll);

        dollCanvas = Renderer.cropToVisible(dollCanvas);

        Renderer.drawToFitCentered(monsterElement, dollCanvas);
        return monsterElement;
    }

  @override
  Future<CanvasElement> draw() async {
      if(canvas == null) canvas = new CanvasElement(width: width, height: height);
      CanvasElement sheetElement = await drawSheetTemplate();

      canvas.context2D.clearRect(0,0,width,height);

      canvas.context2D.drawImage(sheetElement, 0, 0);


      CanvasRenderingContext2D ctx = canvas.context2D;

      for(TextLayer textLayer in textLayers) {
          ctx.fillStyle = textLayer.fillStyle;
          ctx.font = textLayer.font;
          Renderer.wrap_text(ctx,textLayer.text,textLayer.topLeftX,textLayer.topLeftY,textLayer.fontSize,textLayer.maxWidth,"left");
      }

      if(saveLink == null) saveLink = new AnchorElement();
      saveLink.href = canvas.toDataUrl();

      return canvas;
  }
}

