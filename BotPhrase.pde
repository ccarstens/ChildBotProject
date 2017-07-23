public class BotPhrase extends Phrase{

    public static final String BOOL = "BOOL";
    public static final String STRING = "STRING";
    public static final String STRINGPLACEHOLDER = "$STRING";
    public static final String USERNAMEPLACEHOLDER = "$USERNAME";

    public static final int MIC_OFFSET = 500;

    public static final int TYPE_START = 1;
    public static final int TYPE_CONVERSATION = 2;
    public static final int TYPE_LEAVE = 3;
    public static final int TYPE_IDLE_USER = 4;
    public static final int TYPE_EVAL_MEANING = 5;


    public int catID;
    public int typeID;
    public String expectedResponseType;
    public boolean isExit;
    public int nextPhraseTrue;
    public int nextPhraseFalse;
    public boolean containsStringPlaceholder;
    public boolean containsUsernamePlaceholder;
    public int duration;



    public BotPhrase(int _id, DBConnection _db){
        super(_id, _db, "general_phrases");


        this.catID = this.db.getInt("cat_id");
        this.typeID = this.db.getInt("type_id");
        this.expectedResponseType = this.db.getString("expected_response_type");
        this.isExit = this.db.getBoolean("is_exit_point");
        this.nextPhraseTrue = this.db.getInt("follow_up_phrase_id_if_true");
        this.nextPhraseFalse = this.db.getInt("follow_up_phrase_id_if_false");
        this.duration = this.db.getInt("duration");

        this.containsStringPlaceholder = this.content.indexOf(BotPhrase.STRINGPLACEHOLDER) != -1;
        this.containsUsernamePlaceholder = this.content.indexOf(BotPhrase.USERNAMEPLACEHOLDER) != -1;


    }

    public boolean speak(){
        if(this.containsStringPlaceholder || this.containsUsernamePlaceholder){
            this.sayWaitFor(this.content);
        }else{
            this.say(this.content, this.duration, BotPhrase.MIC_OFFSET);
        }
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

    public boolean isBase(){
        return this.typeID > 0;
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

    public BotPhrase getRandomPhraseByType(int _type_id, ArrayList<Integer> _spoken){
        String[] s = new String[_spoken.size()];
        for(int i = 0; i < _spoken.size();i++){
            s[i] = str(_spoken.get(i));
        }
        String q;
        if(s.length == 0){
            q = "SELECT id FROM general_phrases WHERE type_id = " + _type_id;
        }else{
            q = "SELECT id FROM general_phrases WHERE type_id = " + _type_id + " AND id NOT IN (" + join(s, ",") +")";
        }

        int resultCount = this.db.getResultCount(q);
        // println("HERE: " + resultCount);
        if(resultCount == 0){
            return null;
        }else{
            int[] ids = new int[this.db.getResultCount(q)];

            this.db.query(q);
            int i = 0;
            while(this.db.next()){
                ids[i] = this.db.getInt("id");
                i++;
            }
            return new BotPhrase(ids[floor(random(0, (ids.length)))], this.db);
        }




    }

    public void callibrateDuration(){
        int s = millis();
        this.sayWaitFor(this.content);
        this.duration = millis() - s;
        this.db.query("UPDATE general_phrases SET duration = %s WHERE id = %s", this.duration, this.id);
    }

    public void callibrateDurationAll(){
        DBConnection callibrationDB = new DBConnection(this.db.applet);
        DBConnection constructDB = new DBConnection(this.db.applet);
        callibrationDB.query("SELECT * FROM general_phrases");
        while(callibrationDB.next()){
            BotPhrase temp = new BotPhrase(callibrationDB.getInt("id"), constructDB);
            temp.callibrateDuration();
            delay(5);
        }
    }
}
