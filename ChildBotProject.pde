import de.bezier.data.sql.*;
import websockets.*;



DBConnection x = new DBConnection(this);


Conversation c = new Conversation(this, "Lea", "conversation_1");


void setup(){
    println("COUNT: " + x.getResultCount("SELECT * FROM boolean_response_labels WHERE content LIKE '%nein%'"));

    delay(2000);
    c.communicate();

}

void draw(){

}

void webSocketServerEvent(String _message){
    c.onWebSocketMessage(_message);
}
