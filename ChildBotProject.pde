import de.bezier.data.sql.*;
import websockets.*;

Conversation c = new Conversation(this, "Lea", "conversation_1");


void setup(){

    delay(2000);
    c.communicate();

}

void draw(){

}

void webSocketServerEvent(String _message){
    c.onWebSocketMessage(_message);
}
