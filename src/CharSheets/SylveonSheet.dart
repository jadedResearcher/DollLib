import "../../DollRenderer.dart";
import "CharSheet.dart";
import 'dart:async';
import "BarLayer.dart";
import 'dart:html';
import "../loader/loader.dart";

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

    //but what if you don't want STRANGTH?
    BarLayer strength;

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
  List<TextLayer> get textLayers => <TextLayer>[name,age,guardian,owner,handle, heightLayer, weightLayer,fetchModus,species,textColor,gender,specibus,ancestor,heart, spades, diamonds, clubs,className, aspect,proto1, spriteName,proto2,consorts,denizen,land];
  List<BarLayer> get barLayers => <BarLayer>[strength];

  SylveonSheet(Doll doll):super(doll) {
        double lineY = 70.0;
        name = new TextLayer("Name",nameForDoll(),60.0,lineY, fontSize: 18, maxWidth: 235);
        age = new TextLayer("Age","${rand.nextInt(7)+3}",350.0,lineY, fontSize: 18);
        guardian = new TextLayer("Age",guardianForDoll(name.text),540.0,lineY, fontSize: 18, maxWidth: 235);
        owner = new TextLayer("Name","AuthorBot",810.0,lineY, fontSize: 18);

        lineY = 86.0;
        handle = new TextLayer("Handle",handleForDoll(),70.0,lineY, fontSize: 18);
        heightLayer = new TextLayer("Height","???",342.0,lineY, fontSize: 18);
        weightLayer = new TextLayer("Weight","???",413.0,lineY, fontSize: 18);
        fetchModus = new TextLayer("Fetch Modus",randomFetchModus(),564.0,lineY, fontSize: 18);
        species = new TextLayer("Species",getDollType(),824.0,lineY, fontSize: 18);

        lineY = 102.0;
        textColor = new TextLayer("Text Color: ",doll.associatedColor.toStyleString(),132.0,lineY, fontSize: 18);
        gender = new TextLayer("Text Color: ",rand.pickFrom(<String>["F","M","???"]),373.0,lineY, fontSize: 18);
        specibus = new TextLayer("Strife Specibus: ",randomSpecibus(),596.0,lineY, fontSize: 18);
        ancestor = new TextLayer("Ancestor: ","???",832.0,lineY, fontSize: 18);

        lineY = 145.0;
        heart = new TextLayer("Heart Quadrant: ",randomHeart(),48.0,lineY, fontSize: 18, maxWidth: 235);
        spades = new TextLayer("Spades Quadrant: ",randomNotHeart(),322.0,lineY, fontSize: 18, maxWidth: 235);
        lineY = 172.0;
        diamonds = new TextLayer("Diamond Quadrant: ",randomNotHeart(),48.0,lineY, fontSize: 18, maxWidth: 235);
        clubs = new TextLayer("Club Quadrant: ",randomClubs(),322.0,lineY, fontSize: 18, maxWidth: 235);
        
        strength = new BarLayer("Strength", "${rand.nextInt(10)}",0.0,0.0);

        lineY = 728.0;
        className = new TextLayer("Class: ",randomClass(),119.0,lineY, fontSize: 18);
        spriteName = new TextLayer("SpriteName: ","???",334.0,lineY, fontSize: 18);

        lineY = 746.0;
        aspect = new TextLayer("Aspect: ",randomAspect(),127.0,lineY, fontSize: 18);
        proto1 = new TextLayer("Prototype1: ","???",335.0,lineY, fontSize: 18);
        proto2 = new TextLayer("Prototype2: ","???",335.0,762.0, fontSize: 18);
        consorts = new TextLayer("Consorts: ","???",312.0,778.0, fontSize: 18);

        lineY = 794.0;
        land = new TextLayer("Land: ","???",142.0,lineY, fontSize: 18);
        denizen = new TextLayer("Denizen: ","???",413.0,lineY, fontSize: 18);

        //TODO symbol in symbol box
        //TODO: prospit/derse selector
        //TODO come up with custom object for stats, is all parts of stat at once, value between 0 and max value.
        //auto has range selector.





  }

  String randomHeart() {
      if(rand.nextBool()) {
        return nameForDoll();
      }else {
        return "";
      }
  }

    String randomNotHeart() {
        if(doll is HomestuckTrollDoll) {
            return randomHeart();
        }else {
            return "N/A";
        }
    }

    String randomClubs() {
        if(doll is HomestuckTrollDoll) {
            if(rand.nextBool()) {
                return "${nameForDoll()} & ${nameForDoll()}";
            }else {
                return "";
            }
        }else {
            return "N/A";
        }
    }



  String randomFetchModus() {
    List<String> possibilities = <String>["Video Game","Investment","EXP","Computer","Phone","Hacker","Television","Array","HashSet","Stack","Queue","Git","Wallet","Linked List","Queuestack","Tree","Hash Map","Memory","Jenga","Pictionary","Recipe","Fibonacci Heap ","Puzzle","Message in a Bottle ","Tech-Hop","Encryption","Ouija","Miracle","Chastity ","8 Ball","Scratch and Sniff","Pogs","JuJu","Sweet Bro","Purse","Meme","Cards Against Humanity","LARP"];
    return rand.pickFrom(possibilities);
  }
    String randomSpecibus() {
        WeightedList<String> modifiers = new WeightedList<String>();
        modifiers.add("",1.0);
        modifiers.add("1/2",0.5);
        modifiers.add("2x",0.5);
        List<String> possibilities = <String>["hammer","needle","sword","rifle","spoon","fork","pistol","fist","gun","fncysnta","blade","puppet","flashlight","whip","lance","sickle","claw","makeup","chainsaw","cane","club","joker","3dent","trident","wand","bat","stick","harpoon","piano","instrument","craft","grenade","sceptre","ball","aerosol","bomb","bow","broom","bust","glasses","chain","pen","cleaver","knife","dagger","dart","crowbar","fan","fireext","glove","ax","hatchet","hose","iron","ladel","pot","lamp","peppermill","paddle","oar","pipe","candlestick","wrench","tool","saw","meme","pog","marble","plunger","rake","razor","rock","scissor","scythe","shoe","shotgun","stapler","office","trophy","umbrella","vacuum","woodwind","guitar","yoyo"];
        return "${rand.pickFrom(modifiers)}${rand.pickFrom(possibilities)}";
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

      CanvasElement barCanvas = new CanvasElement(width: width, height: height);
      for(BarLayer barLayer in barLayers) {
          ImageElement image = await Loader.getResource((barLayer.imgLoc));
            ctx.drawImage(barCanvas, barLayer.topLeftX, barLayer.topLeftY);
      }
      Palette p = new CharSheetPalette()
      ..aspect_light = tint;
      Renderer.swapPalette(barCanvas,ReferenceColours.CHAR_SHEET_PALETTE, p);

      if(saveLink == null) saveLink = new AnchorElement();
      saveLink.href = canvas.toDataUrl();

      return canvas;
  }
}

