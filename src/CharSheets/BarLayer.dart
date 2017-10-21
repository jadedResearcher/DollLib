import 'dart:html';
class BarLayer {

    Element element;
    int maxValue = 10;
    String folder = "images/CharSheets";
    String value = "0";
    String barName = "bar";
    String name;
    double topLeftX;
    double topLeftY;

    String get imgLoc => "$folder/$barName${value}.png";
    BarLayer(this.name, this.value, this.topLeftX, this.topLeftY, [this.maxValue]) {
        element = new DivElement();
        element.setInnerHtml("$name:");
        Element formWrapper = new DivElement();
        formWrapper.className = "textAreaElement";

        NumberInputElement formElement = new NumberInputElement();
        formElement.value = value;
        formElement.onChange.listen((Event e) {
            print("I felt a change in ${formElement.value}");
            value = formElement.value;
        });

        formWrapper.append(formElement);
        element.append(formWrapper);
    }
}