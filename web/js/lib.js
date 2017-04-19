/**
 * Created by Alex on 11.04.2017.
 */
function showWindow(parent, child) {
    child.css("margin","120px auto 0 auto");
    child.css("display","table");
    child.css("background","rgb(153, 164, 220)");
    child.css("float","none");
    child.css("padding","20px");
    child.css("position","relative");
    parent.css("position","fixed");
    parent.css("width","100%");
    parent.css("height","100%");
    parent.css("top","0");
    parent.css("background-color","rgba(0,0,0,0.5)");
    parent.css("display","block");
    child.append("<button type='button' style='position: absolute;top:5px;right: 5px' onclick='hideWindow($(this).parent().parent())'>X </button>")
}

function hideWindow(parent) {
    parent.hide();
}