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
    ResponsePhrase lastStringResponse;

    Conversation(PApplet _applet, String _voice,  String _table){
        this.applet = _applet;

        this.db = new DBConnection(this.applet);



        this.human = new WebsocketServer(this.applet, 7777, "/childbo");

        this.userSession = new UserSession(new DBConnection(this.applet));

        this.currentPhrase = new BotPhrase(22, this.db);

        ResponsePhrase temp = new ResponsePhrase("hallo lea", this.db);
    }

    void communicate(){
        boolean speakingSuccessful;
        if(this.lastPhrase != null){
            println("!= null");
            if(this.currentPhrase.containsPlaceholder){
                speakingSuccessful = this.currentPhrase.speak(this.lastStringResponse.content);
            }else{
                speakingSuccessful = this.currentPhrase.speak();
            }
        }else{
            speakingSuccessful = this.currentPhrase.speak();
        }
        if(speakingSuccessful){
            if(this.currentPhrase.expectsResponse()){
                this.human.sendMessage("READY");
            }else{
                this.lastPhrase = this.currentPhrase;
                this.currentPhrase = this.lastPhrase.getTrue();
                if(this.currentPhrase != null){
                    this.communicate();
                }else{
                    println("CALL NEXT PHRASE METHOD");
                }
            }

        }
    }

    void onWebSocketMessage(String _message){
        this.lastResponse = new ResponsePhrase(_message, this.db);
        this.lastPhrase = this.currentPhrase;
        this.logResponse();
        if(currentPhrase.isBool()){
            println("Meaning ID: " + this.lastResponse.meaningID);
            if(this.lastResponse.meansYes()){
                println("means yes");
                this.currentPhrase = this.lastPhrase.getTrue();
            }else if(this.lastResponse.meansNo()){
                println("means no");
                this.currentPhrase = this.lastPhrase.getFalse();
            }else{
                println("iche everstehe nichte");
            }
        }else{
            this.lastStringResponse = this.lastResponse;
            println(_message);
            //is string

            this.currentPhrase = this.lastPhrase.getTrue();
        }
        if(this.currentPhrase != null){
            this.communicate();
        }else{
            println("CALL NEXT PHRASE METHOD AFTER RECEIVING RESPONSE");
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

    public void logResponse(){
        this.db.query("INSERT INTO responses (session_id, phrase_id, response_phrase_id) VALUES (%s, %s, %s)", this.userSession.id, this.lastPhrase.id, this.lastResponse.id);
    }
}
