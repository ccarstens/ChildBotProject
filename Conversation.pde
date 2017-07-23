class Conversation{

    public static final int IDLE_TIMEOUT_1 = 12000;

    public static final int LEAVE_CONVERATION_DELAY = 60000;

    protected WebsocketServer human;

    protected PApplet applet;
    protected int port;
    protected String domain;

    protected DBConnection db;

    UserSession userSession;

    protected BotPhrase lastPhrase, currentPhrase, staticPhrase;
    protected ArrayList<BotPhrase> lastPhraseStorage = new ArrayList<BotPhrase>();
    protected ArrayList<BotPhrase> currentPhraseStorage = new ArrayList<BotPhrase>();

    protected ResponsePhrase lastResponse, lastStringResponse;
    protected ArrayList<ResponsePhrase> lastResponseStorage = new ArrayList<ResponsePhrase>();
    protected ArrayList<ResponsePhrase> lastStringResponseStorage = new ArrayList<ResponsePhrase>();
    protected ArrayList<String> modeStack = new ArrayList<String>();

    protected String timeoutMethod;
    protected int timeoutDuration;
    protected long timeoutStart;
    protected boolean terminateTimeout;
    protected boolean timeoutActive;

    public boolean inIdleUserMode, inPlayingMode;
    protected int idleUserModeInterations;

    public ArrayList<Integer> spokenSequences = new ArrayList<Integer>();


    Conversation(PApplet _applet, String _voice,  String _table){
        this.applet = _applet;

        this.db = new DBConnection(this.applet);



        this.human = new WebsocketServer(this.applet, 7777, "/childbo");



        this.terminateTimeout = false;
        this.timeoutActive = false;

        this.inIdleUserMode = false;
        this.idleUserModeInterations = 0;

        this.staticPhrase = new BotPhrase(1, this.db);
        this.launchServer();
        this.startConversation();



    }

    void communicate(){
        boolean speakingSuccessful;
        if(this.lastPhrase != null){
            if(this.currentPhrase.containsStringPlaceholder){

                if(this.currentPhrase.id == 77){
                    String q = "SELECT * FROM responses r LEFT JOIN response_phrases rp ON r.response_phrase_id = rp.id WHERE meaning_id = 100 AND r.phrase_id = 75";
                    int count = this.db.getResultCount(q);
                    speakingSuccessful = this.currentPhrase.speak(str(count));
                }

                speakingSuccessful = this.currentPhrase.speak(this.lastStringResponse.content);

            }else if(this.currentPhrase.containsUsernamePlaceholder){
                if(this.userSession.userName != null){
                    speakingSuccessful = this.currentPhrase.speak(this.userSession.userName);
                }else{
                    this.currentPhrase.content = this.currentPhrase.content.replaceAll("\\" + BotPhrase.USERNAMEPLACEHOLDER, "");
                    speakingSuccessful = this.currentPhrase.speak();
                }

            }else{
                speakingSuccessful = this.currentPhrase.speak();
            }
        }else{
            speakingSuccessful = this.currentPhrase.speak();
        }

        if(this.currentPhrase.typeID == 2){
            this.spokenSequences.add(this.currentPhrase.id);
        }

        if(speakingSuccessful){



            if(this.currentPhrase.expectsResponse()){
                this.human.sendMessage("READY");
                if(this.timeoutActive){
                    println("There is a timeout active but a new one will be set now");
                }
                if(this.inPlayingMode){
                    this.setTimeout(Conversation.IDLE_TIMEOUT_1, "playingMode");
                }else{
                    this.setTimeout(Conversation.IDLE_TIMEOUT_1, "idleUser");
                    println("timeout");
                }


            }else{
                if(this.inIdleUserMode){
                    this.leaveConversation();
                }else if(this.inPlayingMode){
                    this.playingMode();
                }else{

                    if(this.currentPhrase.typeID == 3){
                        this.leaveConversation();
                    }else{
                        this.lastPhrase = this.currentPhrase;
                        this.currentPhrase = this.lastPhrase.getTrue();
                        if(this.currentPhrase != null){
                            this.communicate();
                        }else{
                            println("### HANDLING (communicate) END OF SEQUENCE; HANDLING FOR NEXT SEQUENCE BY GROUP NEEDED ");
                            this.currentPhrase = this.lastPhrase.getRandomPhraseByType(2, this.spokenSequences);
                            if(this.currentPhrase == null){ //all the phrases have been used already);
                                this.currentPhrase = new BotPhrase(137, this.db);
                                this.currentPhrase.speak();
                                this.leaveConversation();
                            }else{
                                this.communicate();
                            }
                        }
                    }
                }
            }
        }
    }

    void onResponseFromUser(String _message){
        println("\n\n\nreceived message " + _message);
        this.terminateTimeout = true;
        this.lastResponse = new ResponsePhrase(_message, this.db);
        this.lastPhrase = this.currentPhrase;

        this.logResponse();

        if(this.inIdleUserMode){
            this.leaveIdleUserMode();
        }else if(this.inPlayingMode){
            this.leavePlayingMode();
        }else{
            if(currentPhrase.isBool()){
                if(this.lastResponse.meansYes()){

                    this.currentPhrase = this.lastPhrase.getTrue();
                }else if(this.lastResponse.meansNo()){

                    this.currentPhrase = this.lastPhrase.getFalse();

                }else if(this.lastResponse.isAmbiguous()){

                    println("### HANDLE AMBIGUOUS RESPONSE");

                }else if(this.lastResponse.meansRepeat()){

                    println("### REPEAT THE CURRENT PHRASE");

                }else{
                    println("### ANSWER NOT UNDERSTOOD - NOT HANDLED ATM");
                }
            }else{
                this.lastStringResponse = this.lastResponse;

                this.currentPhrase = this.lastPhrase.getTrue();
            }

            if(this.currentPhrase != null){
                this.specialActionsOnResponse();
                this.communicate();
            }else{
                println("### (onResponseFromUser) END OF SEQUENCE, HANDLE NEXT SEQUENCE IN SAME GROUP OR GROUP CHANGE");
                // this.currentPhrase = this.lastPhrase.getRandomPhraseByType(2, this.spokenSequences);
                // this.communicate();
            }
        }

    }

    public void logResponse(){
        int sessionID;
        if(this.userSession != null){
            sessionID = this.userSession.id;
        }else{
            sessionID = 0;
        }
        this.db.query("INSERT INTO responses (session_id, phrase_id, response_phrase_id) VALUES (%s, %s, %s)", sessionID, this.lastPhrase.id, this.lastResponse.id);
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

    public void setTimeout(int _millis, String _method){
        println("setTimeout: " + _millis + " " + _method);
        this.timeoutDuration = _millis;
        this.timeoutMethod = _method;
        this.timeoutStart = millis();
        this.timeoutActive = true;
        this.terminateTimeout = false;
    }

    public void timeoutCallback(){
        if(this.timeoutActive){
            if(!this.terminateTimeout){
                // println(millis() - this.timeoutStart);
                if(millis() - this.timeoutStart >= this.timeoutDuration){
                    this.timeoutActive = false;
                    switch(this.timeoutMethod){
                        case "idleUser": {
                            this.enterIdleUserMode();
                            break;
                        }
                        case "playingMode":{
                            this.playingMode();
                            break;
                        }
                    }
                }
            }else{
                this.terminateTimeout = false;
                this.timeoutActive = false;
            }
        }
    }

    protected boolean launchServer(){
        launch("/Applications/Google Chrome.app");
        return true;
    }

    protected void enterIdleUserMode(){
        if(!this.inIdleUserMode){
            println("enter IdleUser Mode");
            this.inIdleUserMode = true;
            println("test");
            this.storePhrasesForModeChange("idleUser");
            println("hey");
            this.idleUser();
        }else{
            this.idleUser();
        }
    }

    protected void leaveIdleUserMode(){
        if(this.inIdleUserMode){
            println("leaving idle user mode");
            this.human.sendMessage("ABORT");
            this.inIdleUserMode = false;
            this.terminateTimeout = true;
            this.loadPhrasesAfterModeChange();
            this.communicate();
        }

    }

    protected void idleUser(){
        println("Idle User");
        for(BotPhrase p : this.currentPhraseStorage){
            print(p.id + " " + p.content);
        }
        print("\n");

        this.human.sendMessage("ABORT");
        if(this.currentPhrase == null){//first
            println("first");
            // this.currentPhrase = this.currentPhraseStorage.get(this.currentPhraseStorage.size() - 1).getRandomPhraseByType(BotPhrase.TYPE_IDLE_USER, this.spokenSequences);
            this.currentPhrase = this.currentPhraseStorage.get(0).getRandomPhraseByType(BotPhrase.TYPE_IDLE_USER, this.spokenSequences);
            this.communicate();
        }else{//follow up
            this.currentPhrase = this.currentPhrase.getTrue();
            this.communicate();
        }




    }

    protected void enterPlayingMode(){
        this.inPlayingMode = true;
        this.playingMode();
    }

    protected void playingMode(){
        delay(5000);
        println("playing mode delay");
        this.currentPhrase = this.staticPhrase.getRandomPhraseByType(6, this.spokenSequences);
        this.communicate();
    }

    protected void leavePlayingMode(){
        this.inPlayingMode = false;
        this.currentPhrase = this.staticPhrase.getRandomPhraseByType(1, this.spokenSequences);
        // this.currentPhrase = new BotPhrase(75, this.db);
        this.userSession = new UserSession(new DBConnection(this.applet));
        this.communicate();
    }

    protected void storePhrasesForModeChange(String _mode){
        this.lastPhraseStorage.add(this.lastPhrase);
        this.currentPhraseStorage.add(this.currentPhrase);
        this.lastResponseStorage.add(this.lastResponse);
        this.lastStringResponseStorage.add(this.lastStringResponse);

        this.modeStack.add(_mode);
        this.currentPhrase = null;
        println(this.modeStack);

        // this.lastPhraseStorage = this.lastPhrase;
        // this.currentPhraseStorage = this.currentPhrase;
        // this.lastResponseStorage = this.lastResponse;
        // this.lastStringResponseStorage = this.lastStringResponse;
        // this.currentPhrase = null;
    }

    protected void loadPhrasesAfterModeChange(){
        if(this.lastPhraseStorage.size() > 0){

            this.lastPhrase = this.lastPhraseStorage.get(this.lastPhraseStorage.size() - 1);
            this.lastPhraseStorage.remove(this.lastPhraseStorage.size() - 1);
        }else{
            this.lastPhrase = null;
        }

        if(this.currentPhraseStorage.size() > 0){
            println("bigger than zero");

            this.currentPhrase = this.currentPhraseStorage.get(this.currentPhraseStorage.size() - 1);
            this.currentPhraseStorage.remove(this.currentPhraseStorage.size() - 1);
        }else{
            this.currentPhrase = null;
        }

        if(this.lastResponseStorage.size() > 0){
            this.lastResponse = this.lastResponseStorage.get(this.lastResponseStorage.size() - 1);
            this.lastResponseStorage.remove(this.lastResponseStorage.size() - 1);
        }else{
            this.lastResponse = null;
        }

        if(this.lastStringResponseStorage.size() > 0){
            this.lastStringResponse = this.lastStringResponseStorage.get(this.lastStringResponseStorage.size() - 1);
            this.lastStringResponseStorage.remove(this.lastStringResponseStorage.size() - 1);
        }else{
            this.lastStringResponse = null;
        }

        if(this.modeStack.size() > 0){
            this.modeStack.remove(this.modeStack.size() - 1);
            if(this.modeStack.size() > 0){
                String mode = this.modeStack.get(this.modeStack.size() - 1);
                println("ENTER NEW MODE" + mode);

            }else{
                println("back to normal");
            }

        }else{
            println("no mode");
        }


        // this.lastPhrase = this.lastPhraseStorage;
        // this.currentPhrase = this.currentPhraseStorage;
        // this.lastResponse = this.lastResponseStorage;
        // this.lastStringResponse = this.lastStringResponseStorage;
    }

    public void leaveConversation(){
        this.userSession.close();
        this.spokenSequences = new ArrayList<Integer>();
        println("LEAVE");
        delay(Conversation.LEAVE_CONVERATION_DELAY);
        println("playing mode now");

        this.enterPlayingMode();

    }

    public void startConversation(){

        this.enterPlayingMode();
    }

    public void nextRandomPhrase(){

    }



}
