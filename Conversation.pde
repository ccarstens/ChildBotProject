class Conversation{
    ChildBot bot;
    WebsocketServer human;

    PApplet applet;
    int port;
    String domain;

    MySQL db;

    Conversation(PApplet _applet, String _voice,  String _table){
        this.applet = _applet;
        this.bot = new ChildBot(this.applet, _voice, _table);

        this.human = new WebsocketServer(this.applet, 7777, "/childbo");

    }

    void communicate(){
        if(this.bot.nextPhrase()){
            //run code afterspeaking, set current question id etc
            this.human.sendMessage("READY");
            println("message sent to semi-non-human");
        }
    }

    void onWebSocketMessage(String _message){

        //run code for anwer processing
        println("HUMAN: " + _message);
        this.communicate();
    }
}
