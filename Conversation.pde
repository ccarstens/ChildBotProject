class Conversation{

    WebsocketServer human;

    PApplet applet;
    int port;
    String domain;

    DBConnection db;

    UserSession userSession;

    BotPhrase lastPhrase;
    BotPhrase currentPhrase;

    ResponsePhrase lastResponse;

    Conversation(PApplet _applet, String _voice,  String _table){
        this.applet = _applet;

        this.db = new DBConnection(this.applet);



        this.human = new WebsocketServer(this.applet, 7777, "/childbo");

        this.userSession = new UserSession(new DBConnection(this.applet));

        this.currentPhrase = new BotPhrase(14, this.db);

        ResponsePhrase temp = new ResponsePhrase("hallo lea", this.db);
    }

    void communicate(){
        boolean speakingSuccessful;
        if(this.lastPhrase != null){
            println("!= null");
            if(this.lastPhrase.isString()){
                println("is string. " + this.lastResponse.content);
                speakingSuccessful = this.currentPhrase.speak(this.lastResponse.content);
            }else{
                speakingSuccessful = this.currentPhrase.speak();
            }
        }else{
            speakingSuccessful = this.currentPhrase.speak();
        }
        if(speakingSuccessful){
            if(this.currentPhrase.expectsResponse()){
                this.human.sendMessage("READY");
            }

        }
    }

    void onWebSocketMessage(String _message){
        this.lastResponse = new ResponsePhrase(_message, this.db);

        if(currentPhrase.isBool()){
            println("is bool");
        }else{
            println(_message);
            //is string
            this.lastPhrase = this.currentPhrase;
            this.currentPhrase = this.currentPhrase.getTrue();
            this.communicate();

        }






        // //run code for anwer processing
        // int[] responsePhraseData = this.db.getResponsePhraseData(_message);
        //
        // this.db.logResponseWithID(this.userSession.id, this.bot.currentPhraseID, responsePhraseData[0]);
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
