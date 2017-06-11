import websockets.*;

class Conversation{
    ChildBot bot;
    WebsocketServer human;

    PApplet applet;
    int port;
    String domain;

    Conversation(PApplet _applet, String _voice, String _host, String _database, String _table, String _user, String _pass, int _port, String _domain){
        this.applet = _applet;
        this.bot = new ChildBot(this.applet, _voice, _host, _database, _table, _user, _pass);

        this.port = _port;
        this.domain = _domain;
        this.human = new WebsocketServer(this.applet, this.port, this.domain);

    }

    void communicate(){
        if(this.bot.nextPhrase()){
            println("Frage: " + this.bot.currentQuestion);
            //run code afterspeaking, set current question id etc
            this.human.sendMessage("READY");
            println("message sent to human");
        }
        if(this.bot.justFinished){

            this.bot.justFinished = false;
        }
    }

    void onWebSocketMessage(String _message){

        //run code for anwer processing
        println("HUMAN: " + _message);
        this.communicate();
    }
}
