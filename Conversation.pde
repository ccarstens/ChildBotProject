class Conversation{

    public static final int IDLE_TIMEOUT_1 = 5000;

    protected WebsocketServer human;

    protected PApplet applet;
    protected int port;
    protected String domain;

    protected DBConnection db;

    UserSession userSession;

    protected BotPhrase lastPhrase, currentPhrase;
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

    public boolean inIdleUserMode;
    protected int idleUserModeInterations;

    public boolean inMeaningEvaluationMode;

    public int[] spokenSequences = new int[1];


    Conversation(PApplet _applet, String _voice,  String _table){
        this.applet = _applet;

        this.db = new DBConnection(this.applet);



        this.human = new WebsocketServer(this.applet, 7777, "/childbo");

        this.userSession = new UserSession(new DBConnection(this.applet));

        this.terminateTimeout = false;
        this.timeoutActive = false;

        this.inIdleUserMode = false;
        this.idleUserModeInterations = 0;

        this.currentPhrase = new BotPhrase(14, this.db);

        this.launchServer();

    }

    void communicate(){
        println("Communicate in Thread : " + Thread.currentThread().getId());
        boolean speakingSuccessful;
        if(this.lastPhrase != null){
            if(this.currentPhrase.containsStringPlaceholder){

                // if(this.inMeaningEvaluationMode){
                    // speakingSuccessful = this.currentPhrase.speak(this.lastResponseStorage.content);
                // }else{
                    speakingSuccessful = this.currentPhrase.speak(this.lastStringResponse.content);
                // }

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

        if(this.currentPhrase.isBase() && this.currentPhrase.typeID < 4){
            int[] temp = new int[this.spokenSequences.length + 1];
            for(int i = 0; i < this.spokenSequences.length; i++){
                temp[i] = this.spokenSequences[i];
            }
            temp[this.spokenSequences.length] = this.currentPhrase.id;
            this.spokenSequences = temp;
        }

        if(speakingSuccessful){
            if(this.currentPhrase.expectsResponse()){
                this.human.sendMessage("READY");
                if(this.timeoutActive){
                    println("There is a timeout active but a new one will be set now");
                }
                this.setTimeout(Conversation.IDLE_TIMEOUT_1, "idleUser");
            }else{
                if(this.inMeaningEvaluationMode){
                    this.leaveMeaningEvaluationMode();
                }else if(this.inIdleUserMode){
                    println("LEAVE");
                }else{


                    this.lastPhrase = this.currentPhrase;
                    this.currentPhrase = this.lastPhrase.getTrue();
                    if(this.currentPhrase != null){
                        this.communicate();
                    }else{
                        //NEXT PHRASE SEQUENCE^
                        this.currentPhrase = this.lastPhrase.getRandomPhraseByType(2, this.spokenSequences);
                        this.communicate();
                    }
                }
            }

        }
    }

    void onResponseFromUser(String _message){
        println("received message " + _message);
        this.terminateTimeout = true;
        this.lastResponse = new ResponsePhrase(_message, this.db);
        this.lastPhrase = this.currentPhrase;

        boolean meaningEvalStateOnEntry = this.inMeaningEvaluationMode;

        this.logResponse();

        if(this.inIdleUserMode){
            this.leaveIdleUserMode();
        }else{
            if(currentPhrase.isBool()){
                println("Meaning ID: " + this.lastResponse.meaningID);
                if(this.lastResponse.meansYes()){
                    println("means yes");

                    // if(this.inMeaningEvaluationMode){
                    //     this.lastResponseStorage.setMeaningYes();
                    //     this.leaveMeaningEvaluationMode();
                    // }

                    this.currentPhrase = this.lastPhrase.getTrue();
                }else if(this.lastResponse.meansNo()){
                    println("means no");

                    // if(this.inMeaningEvaluationMode){
                    //     this.lastResponseStorage.setMeaningNo();
                    //     this.leaveMeaningEvaluationMode();
                    // }

                    this.currentPhrase = this.lastPhrase.getFalse();
                }else{
                    println("ANSWER NOT UNDERSTOOD");

                    if(!this.inMeaningEvaluationMode){
                        this.meaningEvaluation();
                    }else{
                        println("HANDLE NEXT PHRASE WHEN EVALUATION FAILED");
                    }
                }
            }else{
                this.lastStringResponse = this.lastResponse;
                println(_message);
                //is string

                this.currentPhrase = this.lastPhrase.getTrue();
            }
            if(meaningEvalStateOnEntry || !this.inMeaningEvaluationMode){
                if(this.currentPhrase != null){
                    this.specialActionsOnResponse();
                    this.communicate();
                }else{
                    println("CALL NEXT PHRASE METHOD AFTER RECEIVING RESPONSE");
                }
            }
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
            this.storePhrasesForModeChange("idleUser");
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
        for(BotPhrase p : this.currentPhraseStorage){
            print(p.id + " " + p.content);
        }
        print("\n");

        this.human.sendMessage("ABORT");
        if(this.currentPhrase == null){//first
            this.currentPhrase = this.currentPhraseStorage.get(this.currentPhraseStorage.size() - 1).getRandomPhraseByType(BotPhrase.TYPE_IDLE_USER, this.spokenSequences);
            this.communicate();
        }else{//follow up
            this.currentPhrase = this.currentPhrase.getTrue();
            this.communicate();
        }




    }

    protected void enterMeaningEvaluationMode(){
        if(!this.inMeaningEvaluationMode){
            this.inMeaningEvaluationMode = true;
            this.storePhrasesForModeChange("meaningEvaluation");
        }
    }

    protected void leaveMeaningEvaluationMode(){
        // if(this.inMeaningEvaluationMode && this.currentPhrase.isExit){
        //     this.inMeaningEvaluationMode = false;
        //
        //     if(this.lastResponse.meansYes()){
        //         this.currentPhraseStorage = this.currentPhraseStorage.getTrue();
        //     }else if(this.lastResponse.meansNo()){
        //         this.currentPhraseStorage = this.currentPhraseStorage.getFalse();
        //     }
        //
        //     this.loadPhrasesAfterModeChange();
        //     this.terminateTimeout = true;
        //     this.communicate();
        // }
    }

    protected void meaningEvaluation(){
        // this.enterMeaningEvaluationMode();
        // if(this.currentPhrase == null){
        //     this.currentPhrase = this.currentPhraseStorage.getRandomPhraseByType(BotPhrase.TYPE_EVAL_MEANING, this.spokenSequences);
        // }else{
        //     this.currentPhrase = this.currentPhrase.getTrue();
        // }
        // this.communicate();
    }

    protected void storePhrasesForModeChange(String _mode){
        this.lastPhraseStorage.add(this.lastPhrase);
        this.currentPhraseStorage.add(this.currentPhrase);
        this.lastResponseStorage.add(this.lastResponse);
        this.lastStringResponseStorage.add(this.lastStringResponse);

        this.modeStack.add(_mode);
        this.currentPhrase = null;
        println(this.lastPhraseStorage);

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



}
