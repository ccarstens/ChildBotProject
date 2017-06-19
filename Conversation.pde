class Conversation implements Runnable{

    protected WebsocketServer human;

    protected PApplet applet;
    protected int port;
    protected String domain;

    protected DBConnection db;

    UserSession userSession;

    protected BotPhrase lastPhrase;
    protected BotPhrase currentPhrase;
    protected BotPhrase currentInformingPhrase;

    protected ResponsePhrase lastResponse;
    protected ResponsePhrase lastStringResponse;

    protected String timeoutMethod;
    protected int timeoutMillis;

    volatile boolean terminateTimeout;



    Conversation(PApplet _applet, String _voice,  String _table){
        this.applet = _applet;

        this.db = new DBConnection(this.applet);



        this.human = new WebsocketServer(this.applet, 7777, "/childbo");

        this.userSession = new UserSession(new DBConnection(this.applet));

        this.currentPhrase = new BotPhrase(14, this.db);

        this.terminateTimeout = false;

        ResponsePhrase temp = new ResponsePhrase("hallo lea", this.db);

    }

    void communicate(){
        println("Communicate in Thread : " + Thread.currentThread().getId());
        boolean speakingSuccessful;
        if(this.lastPhrase != null){
            if(this.currentPhrase.containsStringPlaceholder){
                speakingSuccessful = this.currentPhrase.speak(this.lastStringResponse.content);
            }else if(this.currentPhrase.containsUsernamePlaceholder){
                speakingSuccessful = this.currentPhrase.speak(this.userSession.userName);

            }else{
                speakingSuccessful = this.currentPhrase.speak();
            }
        }else{
            speakingSuccessful = this.currentPhrase.speak();
        }
        if(speakingSuccessful){
            if(this.currentPhrase.expectsResponse()){
                this.human.sendMessage("READY");
                this.setTimeout(5000, "reactToIdleUser");
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
        terminateTimeout = true;
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
            this.specialActionsOnResponse();
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
                println(tempUserName);
                this.userSession.userName = tempUserName;
            }
        }

    }

    public void reactToIdleUser(){
        this.human.sendMessage("ABORT");
        this.currentInformingPhrase = new BotPhrase(100, this.db);
        println("Before speaking informing message");
        this.currentInformingPhrase.speak();
        this.communicate();
    }

    public void setTimeout(int _millis, String _method){
        this.timeoutMillis = _millis;
        this.timeoutMethod = _method;
        (new Thread(this)).start();
    }

    public void run(){
        println(Thread.currentThread().getId());
        print("Waiting for " + this.timeoutMillis + " milliseconds");
        delay(this.timeoutMillis);
        println("Before !terminateTimout");
        if(!terminateTimeout){
            switch(this.timeoutMethod){
                case "reactToIdleUser": {
                    this.reactToIdleUser();
                    break;
                }

            }
        }
        this.terminateTimeout = false;

    }

}
