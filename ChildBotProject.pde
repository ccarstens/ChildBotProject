import de.bezier.data.sql.*;
import websockets.*;
import java.util.Date;
import java.lang.*;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

boolean run = true;
boolean callibrate = false;

Conversation c;


void setup(){



    if(run){
        delay(2000);
        c = new Conversation(this, "Lea", "conversation_1");
    }else if(!callibrate){





        BotPhrase x = new BotPhrase(152, new DBConnection(this));
        x.callibrateDuration();


        // BotPhrase b = new BotPhrase(2, new DBConnection(this));
        // ArrayList<Integer> s = new ArrayList<Integer>();
        // for(int i = 0;i< 20;i++){
        //     BotPhrase x = b.getRandomPhraseByTypeOrGroup(7, s);
        //     println(x.content);
        // }




    }


    if(callibrate){
        BotPhrase x = new BotPhrase(2, new DBConnection(this));
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
