import de.bezier.data.sql.*;
import websockets.*;
import java.util.Date;
import java.lang.*;
import java.util.concurrent.TimeUnit;


boolean run = true;


    Conversation c;


void setup(){

    delay(2000);

    if(run){
        c = new Conversation(this, "Lea", "conversation_1");
    }

    BotPhrase x = new BotPhrase(1, new DBConnection(this));
    if(!run){
        x.callibrateDurationAll();
    }
    if(!run){
        // int[] s = {0, 14};
        // BotPhrase x = new BotPhrase(14, new DBConnection(this));
        // BotPhrase temp = x.getRandomPhraseByType(2, s);
        // temp.speak();
        // println(temp.id);
    }
}

void draw(){
    if(run){
        c.timeoutCallback();
    }
}

void webSocketServerEvent(String _message){
    if(run){
        c.onResponseFromUser(_message);
    }
}

void exit(){
    if(run){
        c.userSession.close();
    }
    println(c.spokenSequences);
    super.exit();
}
