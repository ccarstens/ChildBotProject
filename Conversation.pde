class Conversation{
    ChildBot bot;
    WebsocketServer human;

    PApplet applet;
    int port;
    String domain;

    DBConnection logConnection;

    Conversation(PApplet _applet, String _voice,  String _table){
        this.applet = _applet;

        this.logConnection = new DBConnection(this.applet);

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
        int[] responsePhraseData = this.logConnection.getResponsePhraseData(_message);

        this.logConnection.logResponseWithID(this.bot.currentPhraseID, responsePhraseData[0]);
        if(responsePhraseData[1] == DBConnection.MEANING_YES){
            println("Die Aussage des Users war bejahend");
        }else if(responsePhraseData[1] == DBConnection.MEANING_NO){
            println("Die Aussage des Users war verneinend");
        }else{
            println("Es konnte keine Aussage erkannt werden.");
        }



        println("HUMAN: " + _message);
        this.communicate();
    }
}
