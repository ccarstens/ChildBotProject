import de.bezier.data.sql.*;
import websockets.*;
import java.util.Date;
import java.lang.*;
import java.util.concurrent.TimeUnit;


boolean run = false;
boolean callibrate = false;

Conversation c;


void setup(){



    if(run){
        delay(2000);
        c = new Conversation(this, "Lea", "conversation_1");
    }else{
        BotPhrase x = new BotPhrase(1, new DBConnection(this));
        ArrayList<Integer> spoken = new ArrayList<Integer>();

        for(int i = 0;i< 100;i++){
            BotPhrase y = x.getRandomPhraseByType(5, spoken);
            println(y.id);
        }
    }


    if(callibrate){
        BotPhrase x = new BotPhrase(1, new DBConnection(this));
        x.callibrateDurationAll();
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
        println(c.spokenSequences);
    }

    super.exit();
}
