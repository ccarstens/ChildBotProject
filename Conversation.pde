class Conversation{

    WebsocketServer human;

    PApplet applet;
    int port;
    String domain;

    DBConnection logConnection;

    UserSession userSession;

    BotPhrase currentPhrase;

    String lastResponse;

    Conversation(PApplet _applet, String _voice,  String _table){
        this.applet = _applet;

        this.logConnection = new DBConnection(this.applet);



        this.human = new WebsocketServer(this.applet, 7777, "/childbo");

        this.userSession = new UserSession(new DBConnection(this.applet));

        this.currentPhrase = new BotPhrase(14, this.logConnection);

        ResponsePhrase temp = new ResponsePhrase("hallo lea", this.logConnection);
    }

    void communicate(){
        if(this.currentPhrase.speak()){
            if(this.currentPhrase.expectsResponse()){
                this.human.sendMessage("READY");
            }

        }
    }

    void onWebSocketMessage(String _message){








        // //run code for anwer processing
        // int[] responsePhraseData = this.logConnection.getResponsePhraseData(_message);
        //
        // this.logConnection.logResponseWithID(this.userSession.id, this.bot.currentPhraseID, responsePhraseData[0]);
        // if(responsePhraseData[1] == DBConnection.MEANING_YES){
        //     println("Die Aussage des Users war bejahend");
        // }else if(responsePhraseData[1] == DBConnection.MEANING_NO){
        //     println("Die Aussage des Users war verneinend");
        // }else{
        //     println("Die Bedeutung konnte nicht erkannt werden.");
        // }
        //
        //
        //
        // println("HUMAN: " + _message);
        // this.communicate();
    }
}
