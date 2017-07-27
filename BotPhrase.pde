public class BotPhrase extends Phrase{

    public static final String BOOL = "BOOL";
    public static final String STRING = "STRING";
    public static final String STRINGPLACEHOLDER = "$STRING";
    public static final String USERNAMEPLACEHOLDER = "$USERNAME";

    public static final String REGEX_DELAY_START = "^\\$DEL(\\d+)\\s*";
    public static final String REGEX_DELAY_END = "\\s*\\$DEL(\\d+)$";

    public static final int MIC_OFFSET = 300;

    public static final int TYPE_START = 1;
    public static final int TYPE_CONVERSATION = 2;
    public static final int TYPE_LEAVE = 3;
    public static final int TYPE_IDLE_USER = 4;
    public static final int TYPE_PLAYING = 5;
    public static final int TYPE_AMB_FOLLOW = 6;
    public static final int TYPE_REACTION = 6;

    public static final int GROUP_CASUAL = 20;
    public static final int GROUP_DEEP = 21;
    public static final int GROUP_DRAMA = 22;



    public int groupID;
    public int typeID;
    public String expectedResponseType;
    public boolean isExit;

    public int reactionYes;
    public int reactionNo;
    public int reactionAmb;

    public int nextPhraseYes;
    public int nextPhraseNo;
    public int nextPhraseAmb;

    public boolean containsStringPlaceholder;
    public boolean containsUsernamePlaceholder;
    public int duration;

    public int delayStart;
    public int delayEnd;



    public BotPhrase(int _id, DBConnection _db){
        super(_id, _db, "general_phrases");


        this.groupID = this.db.getInt("group_id");
        this.typeID = this.db.getInt("type_id");
        this.expectedResponseType = this.db.getString("expected_response_type");
        this.isExit = this.db.getBoolean("is_sequence_end");

        this.reactionYes = this.db.getInt("reaction_yes");
        this.reactionNo = this.db.getInt("reaction_no");
        this.reactionAmb = this.db.getInt("reaction_amb");

        this.nextPhraseYes = this.db.getInt("follow_up_yes");
        this.nextPhraseNo = this.db.getInt("follow_up_no");
        this.nextPhraseAmb = this.db.getInt("follow_up_amb");
        this.duration = this.db.getInt("duration");

        this.containsStringPlaceholder = this.content.indexOf(BotPhrase.STRINGPLACEHOLDER) != -1;
        this.containsUsernamePlaceholder = this.content.indexOf(BotPhrase.USERNAMEPLACEHOLDER) != -1;
        this.extractDelays();

    }

    public boolean speak(){

        if(this.delayStart > 0) delay(this.delayStart);

        if(this.containsStringPlaceholder || this.containsUsernamePlaceholder || !this.expectsResponse() || this.delayEnd > 0){
            this.sayWaitFor(this.content);
            if(this.delayEnd > 0) delay(this.delayEnd);
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

    public void reactToYes(){
        println("REACT YES IN BOTPHRASE");
        if(this.reactionYes != 0){
            BotPhrase reactionTemp = this.getRandomPhraseByTypeOrGroup(this.reactionYes, new ArrayList<Integer>());
            reactionTemp.speak();
        }
    }

    public void reactToNo(){
        println("REACT NO IN BOTPHRASE");
        if(this.reactionNo != 0){
            BotPhrase reactionTemp = this.getRandomPhraseByTypeOrGroup(this.reactionNo, new ArrayList<Integer>());
            reactionTemp.speak();
        }
    }

    public void reactToAmb(){
        println("REACT AMB IN BOTPHRASE");
        if(this.reactionAmb != 0){
            BotPhrase reactionTemp = this.getRandomPhraseByTypeOrGroup(this.reactionAmb, new ArrayList<Integer>());
            reactionTemp.speak();
        }
    }

    public BotPhrase getFollowUpYes(){
        if(this.nextPhraseYes > 0){
            return new BotPhrase(this.nextPhraseYes, this.db);
        }
        return null;

    }

    public BotPhrase getFollowUpNo(){
        return new BotPhrase(this.nextPhraseNo, this.db);
    }

    public BotPhrase getFollowUpAmb(){
        return new BotPhrase(this.nextPhraseAmb, this.db);
    }

    public BotPhrase getRandomPhraseByTypeOrGroup(int _testTypeGroupID, ArrayList<Integer> _spoken){
        String[] s = new String[_spoken.size()];
        for(int i = 0; i < _spoken.size();i++){
            s[i] = str(_spoken.get(i));
        }
        String q;
        String column;

        if(_testTypeGroupID >= 10) column = "group_id";
        else column = "type_id";

        if(s.length == 0){
            q = "SELECT id FROM general_phrases WHERE " + column + " = " + _testTypeGroupID;
        }else{
            q = "SELECT id FROM general_phrases WHERE " + column + " = " + _testTypeGroupID + " AND id NOT IN (" + join(s, ",") +")";
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
        callibrationDB.query("SELECT * FROM general_phrases WHERE content <> '' AND id > 100");
        while(callibrationDB.next()){
            BotPhrase temp = new BotPhrase(callibrationDB.getInt("id"), constructDB);
            temp.callibrateDuration();
            delay(5);
        }
    }

    public void extractDelays(){
        Pattern patternStart = Pattern.compile(BotPhrase.REGEX_DELAY_START);
        Pattern patternEnd = Pattern.compile(BotPhrase.REGEX_DELAY_END);

        Matcher matcherStart = patternStart.matcher(this.content);
        if(matcherStart.find()){
            this.delayStart = Integer.parseInt(matcherStart.group(1));
            this.content = matcherStart.replaceAll("");
        }

        Matcher matcherEnd = patternEnd.matcher(this.content);
        if(matcherEnd.find()){
            this.delayEnd = Integer.parseInt(matcherEnd.group(1));
            this.content = matcherEnd.replaceAll("");
        }

    }
}
