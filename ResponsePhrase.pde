class ResponsePhrase extends Phrase{

    int meaningID;

    ResponsePhrase(int _id, DBConnection _db){
        super(_id, _db, "response_phrases");

        this.meaningID = this.db.getInt("meaning_id");
    }
}
