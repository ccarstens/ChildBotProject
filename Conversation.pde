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

        this.currentPhrase = new BotPhrase(14, this.db);

        ResponsePhrase temp = new ResponsePhrase("hallo lea", this.db);
    }

    void communicate(){
        boolean speakingSuccessful;
        if(this.lastPhrase != null){
            println("!= null");
            if(this.currentPhrase.containsStringPlaceholder){
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

    void onResponseFromUser(String _message){
        this.lastResponse = new ResponsePhrase(_message, this.db);
        this.lastPhrase = this.currentPhrase;
        this.specialActionsOnResponse();
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
    }

    public void logResponse(){
        this.db.query("INSERT INTO responses (session_id, phrase_id, response_phrase_id) VALUES (%s, %s, %s)", this.userSession.id, this.lastPhrase.id, this.lastResponse.id);
    }

    public void specialActionsOnResponse(){
        if(this.lastPhrase != null){
            if(this.lastPhrase.id == 15){
                String tempUserName = this.lastStringResponse.content.replaceAll("(?i)\\b(ich|bin|ist|heiße|mein|name|hallo|hi|nennt|man|mich|kennt|als|der|die|leute|nennen| )\\b", "");
                this.userSession.userName = tempUserName;
            }
        }

    }
}
