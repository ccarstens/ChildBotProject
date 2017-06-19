class BotPhrase extends Phrase{

    public static final String BOOL = "BOOL";
    public static final String STRING = "STRING";
    public static final String STRINGPLACEHOLDER = "$STRING";
    public static final String USERNAMEPLACEHOLDER = "$USERNAME";

    public int catID;
    public boolean isBase;
    public String expectedResponseType;
    public boolean isExit;
    public int nextPhraseTrue;
    public int nextPhraseFalse;
    public boolean containsStringPlaceholder;
    public boolean containsUsernamePlaceholder;



    public BotPhrase(int _id, DBConnection _db){
        super(_id, _db, "general_phrases");


        this.catID = this.db.getInt("cat_id");
        this.isBase = this.db.getBoolean("is_base");
        this.expectedResponseType = this.db.getString("expected_response_type");
        this.isExit = this.db.getBoolean("is_exit_point");
        this.nextPhraseTrue = this.db.getInt("follow_up_phrase_id_if_true");
        this.nextPhraseFalse = this.db.getInt("follow_up_phrase_id_if_false");

        this.containsStringPlaceholder = this.content.indexOf(BotPhrase.STRINGPLACEHOLDER) != -1;
        this.containsUsernamePlaceholder = this.content.indexOf(BotPhrase.USERNAMEPLACEHOLDER) != -1;


    }

    public boolean speak(){
        this.say(this.content);
        return true;
    }

    public boolean speak(String _response){
        this.content = this.content.replaceAll("(\\" + BotPhrase.STRINGPLACEHOLDER + "|\\" + BotPhrase.USERNAMEPLACEHOLDER + ")", _response);
        return this.speak();

    }

    public boolean expectsResponse(){
        if(this.expectedResponseType.length() == 0){
            return false;
        }
        return true;
    }

    public boolean isBool(){
        return this.expectedResponseType.equals(BotPhrase.BOOL);
    }

    public boolean isString(){
        return this.expectedResponseType.equals(BotPhrase.STRING);
    }

    public BotPhrase getTrue(){
        if(this.nextPhraseTrue > 0){
            return new BotPhrase(this.nextPhraseTrue, this.db);
        }
        return null;

    }

    public BotPhrase getFalse(){
        return new BotPhrase(this.nextPhraseFalse, this.db);
    }
}
