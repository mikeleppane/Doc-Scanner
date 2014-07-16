function createAreaObject(cw,ch) {
    var component = Qt.createComponent(Qt.resolvedUrl("../content/Area.qml"));
    if (component.status === Component.Ready) {
        var object = component.createObject(page, {"cHeight": ch, "cWidth": cw});
        if (object === null) {
            console.log("error creating Area object...");
            console.log(component.errorString());
            return null;
        }
        return object;
    } else if (component.status === Component.Error) {
        console.log("error loading Area component");
        console.log(component.errorString());
    }
}
