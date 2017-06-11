import de.bezier.data.sql.*;
import websockets.*;

Conversation c = new Conversation(this, "Lea",  "localhost:8889", "childbot", "conversation_1", "root", "root", 7777, "/childbo");

void setup(){
    delay(2000);
    c.communicate();

}

void draw(){

}

void webSocketServerEvent(String _message){
    c.onWebSocketMessage(_message);
}
