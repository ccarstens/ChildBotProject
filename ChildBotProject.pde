import de.bezier.data.sql.*;
import websockets.*;
import java.util.Date;
import java.lang.*;




Conversation c = new Conversation(this, "Lea", "conversation_1");

void setup(){
    delay(2000);
    //c.communicate();
    BotPhrase x = new BotPhrase(13, new DBConnection(this));
    x.callibrateDuration();
}

void draw(){
    //c.timeoutCallback();
}

void webSocketServerEvent(String _message){
    //c.onResponseFromUser(_message);
}

void exit(){
    c.userSession.close();

    super.exit();
}
