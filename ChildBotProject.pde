import de.bezier.data.sql.*;
import websockets.*;
import java.util.Date;




Conversation c = new Conversation(this, "Lea", "conversation_1");

BotPhrase bp = new BotPhrase(66, new DBConnection(this));



void setup(){
println(bp.content);
    delay(2000);
    //c.communicate();


}

void draw(){

}

void webSocketServerEvent(String _message){
    c.onWebSocketMessage(_message);
}

void exit(){
    c.userSession.close();

    super.exit();
}
