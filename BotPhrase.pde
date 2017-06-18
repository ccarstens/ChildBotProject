class BotPhrase extends Phrase{

    int catID;
    boolean isBase;
    String expectedResponseType;
    boolean isExit;
    int nextPhraseTrue;
    int nextPhraseFalse;



    BotPhrase(int _id, DBConnection _db){
        super(_id, _db, "general_phrases");


        this.catID = this.db.getInt("cat_id");
        this.isBase = this.db.getBoolean("is_base");
        this.expectedResponseType = this.db.getString("expected_response_type");
        this.isExit = this.db.getBoolean("is_exit_point");
        this.nextPhraseTrue = this.db.getInt("follow_up_phrase_id_if_true");
        this.nextPhraseFalse = this.db.getInt("follow_up_phrase_id_if_false");
    }

    boolean speak(){
        this.say(this.content);
        return true;
    }

    boolean expectsResponse(){
        if(this.expectedResponseType.length() == 0){
            return false;
        }
        return true;
    }
}
