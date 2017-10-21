import "../../DollRenderer.dart";
import "CharSheet.dart";
import 'dart:async';
import 'dart:html';
/*
Based on the char sheet by Sylveon on discord
https://linkedsylveon.tumblr.com/
 */

class SylveonSheet extends CharSheet {

    @override
    int width = 1000;
    @override

    int height = 825;

    @override
    int type = 1;

    TextLayer name;
    TextLayer age;
    TextLayer guardian;
    TextLayer owner;
    TextLayer handle;
    TextLayer heightLayer;
    TextLayer weight;
    TextLayer fetchModus;
    TextLayer species;
    TextLayer textColor;
    TextLayer gender;
    TextLayer specibus;
    TextLayer ancestor;
    TextLayer weightLayer;
    TextLayer heart;
    TextLayer diamonds;
    TextLayer clubs;
    TextLayer spades;
    TextLayer className;
    TextLayer aspect;
    TextLayer spriteName;
    TextLayer proto1;
    TextLayer proto2;
    TextLayer consorts;
    TextLayer denizen;
    TextLayer land;
    //TODO checkboxes for prospit and derse (can pick both)
    //TODO drop range selectors for stats

    //want to be able to get layers independantly
  @override
  List<TextLayer> get textLayers => <TextLayer>[name,age,guardian,owner,handle];

  SylveonSheet(Doll doll):super(doll) {
        name = new TextLayer("Name",nameForDoll(),60.0,70.0, fontSize: 18, maxWidth: 235);
        age = new TextLayer("Age","${rand.nextInt(7)+3}",350.0,70.0, fontSize: 18);
        guardian = new TextLayer("Age",guardianForDoll(name.text),540.0,70.0, fontSize: 18);
        owner = new TextLayer("Name","AuthorBot",810.0,70.0, fontSize: 18);
        handle = new TextLayer("Handle",handleForDoll(),70.0,85.0, fontSize: 18);




  }

    Future<CanvasElement>  drawDoll(Doll doll) async {
        CanvasElement monsterElement = new CanvasElement(width:375, height: 480);
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
      CanvasElement dollElement = await drawDoll(doll);
      //Renderer.drawBG(dollElement, ReferenceColours.RED, ReferenceColours.RED);


      canvas.context2D.clearRect(0,0,width,height);

      canvas.context2D.drawImage(sheetElement, 0, 0);
      canvas.context2D.drawImage(dollElement,590, 180);


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

