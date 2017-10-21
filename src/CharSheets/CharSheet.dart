import "../../DollRenderer.dart";
import 'dart:async';
import 'dart:html';
/*
In addition to providing a way for ppl to share and visualize their chars,
I could use variations on this to set up chars for a particular sim.

Would need to be able to import a char sheet in it's entiretiy to a thing.
Or at least stats.
TODO: Worry about this in the future.
 */
abstract class CharSheet {
    //actual image name of sheet should be type num.
    String folder = "images/CharSheets";
    int type = 0;
    int width = 0;
    int height = 0;
    Random rand;
    Doll doll;
    List<TextLayer> get textLayers;
    CanvasElement canvas;
    Colour tint;
    AnchorElement saveLink;

    CharSheet(Doll this.doll) {
        rand = new Random();
        tint = new Colour(rand.nextInt(255),rand.nextInt(255), rand.nextInt(255));
    }

    Element makeDollLoader() {
        Element ret = new DivElement();
        ret.setInnerHtml("Doll URL: ");
        TextAreaElement dollArea = new TextAreaElement();
        dollArea.value = doll.toDataBytesX();
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Load Doll");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            doll = Doll.loadSpecificDoll(dollArea.value);
            draw();
        });
        return ret;
    }

    Element makeTextLoader() {
        Element ret = new DivElement();
        for(TextLayer tl in textLayers) {
            ret.append(tl.element);
        }
        ButtonElement button = new ButtonElement();
        button.setInnerHtml("Load Text");

        button.onClick.listen((Event e) {
            print("redrawing after loading text.");
            draw();
        });

        ret.append(button);
        return ret;
    }



    Element makeTintSelector() {
        Element ret = new DivElement();
        ret.setInnerHtml("Card Tint: ");
        InputElement colorPicker = new InputElement();
        colorPicker.type = "color";
        colorPicker.value = tint.toStyleString();
        colorPicker.onChange.listen((Event e) {
            tint = new Colour.fromStyleString(colorPicker.value);
            draw();
        });

        ret.append(colorPicker);
        return ret;
    }


    //draws a text area for each text element, one for the doll, and a color picker for tint.
    Element makeForm() {
        Element ret = new DivElement();
        ret.className = "cardForm";
        ret.append(makeDollLoader());
        ret.append(makeTintSelector());
        ret.append(makeTextLoader());
        ret.append(makeSaveButton());

        return ret;
    }

    Future<CanvasElement> drawSheetTemplate() async{
        CanvasElement cardElement = new CanvasElement(width: width, height: height);
        await Renderer.drawWhateverFuture(cardElement, "$folder/$type.png");
        return cardElement;
    }

    Element makeSaveButton() {
        Element ret = new DivElement();
        ret.className = "paddingTop";
        if(saveLink == null) saveLink = new AnchorElement();
        saveLink.href = canvas.toDataUrl();
        saveLink.target = "_blank";
        saveLink.setInnerHtml("Download PNG?");

        ret.append(saveLink);
        return ret;
    }





    Future<CanvasElement> draw() async {
        throw("ABSTRACT DOESNT DO THIS");
    }

    String nameForDoll() {
        if(doll is HomestuckTrollDoll) return trollName();
        if(doll is HomestuckDoll) return humanName();
        return randomAsFuckName();
    }

    //just random shit. 4 letters, then 6 letters.
     String humanName() {
         List<String> firstNames = <String>["John","Dave","Fred","Rose","Dirk","Ruby","Roxy","Romy","Jade","Jane","Jake","Jill","Jack","Dale","Burt","Bess","Beth","Jimm","Joey","Jude","Jann","Jenn","Geof", "Andy","Amii","Chris","Abby", "Abel","Adam","Alex","Anna","Bill","Brad","Buck","Carl","Chad","Cody","Dick","Rich","Dora","Ella","Evan","Emil","Eric","Erin","Finn","Glen","Greg","Hank","Hugo","Ivan","Jean","Josh","Kent","Kyle","Lars","Levi","Lois","Lola","Luke","Mark","Mary","Neal","Nora","Opal","Otto","Pete","Paul","Rosa","Ruth","Ryan","Scot","Sean","Skip","Toby","Todd","Tony","Troy","Vern","Vick","Wade","Walt","Will","Zack","Zeke","Zoey","Phil"];
         List<String> lastNames = <String>["Cipher","Egbert","Lalonde","Harley","Crocker","Roberts","Brockman","Stephenson","Fox","McClure","Baker","Wilson","Parker","White"];
        return "${rand.pickFrom(firstNames)} ${rand.pickFrom(lastNames)}";
    }

    //just generate random vaguely pronouncable combos of 6 letters.
     String trollName()
    {
        List<String> letters = <String>["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
        List<String> vowels = <String>["a","e","i","o","u"];
        String ret = "${rand.pickFrom(letters).toUpperCase()}${rand.pickFrom(vowels)}";
        //troll name is guaranted to have a vowel p frequently so it's pronuncable. small chance of double vowel.
        for(int i = 0; i<2; i++) {
            ret += "${rand.pickFrom(letters)}${rand.pickFrom(vowels)}";
        }
        //last name
        ret += " ${rand.pickFrom(letters).toUpperCase()}${rand.pickFrom(vowels)}";
        for(int i = 0; i<2; i++) {
            ret += "${rand.pickFrom(letters)}${rand.pickFrom(vowels)}";
        }

        return ret;
    }

    String randomAsFuckName() {
        List<String> firstNames = <String>["Nic","Lil","Liv","Charles","Meowsers","Casey","Fred","Kid","Meowgon","Fluffy","Meredith","Bill","Ted","Frank","Flan","Squeezykins"];
        List<String> lastNames = <String>["Cage","Sebastion","Taylor","Dutton","von Wigglebottom","von Salamancer","Savage","Rock","Spangler","Fluffybutton","the Third, esquire.","S Preston","Logan","the Shippest","Clowder","Squeezykins","Boi"];

        return "${rand.pickFrom(firstNames)} ${rand.pickFrom(lastNames)}";
    }


}