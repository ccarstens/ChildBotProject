class ResponsePhrase extends Phrase{
    public static final int MEANING_YES = 100;
    public static final int MEANING_NO = 101;

    public int meaningID;

    public ResponsePhrase(int _id, DBConnection _db){
        super(_id, _db, "response_phrases");

        this.meaningID = this.db.getInt("meaning_id");
    }

    public ResponsePhrase(String _content, DBConnection _db){
        super(1, _db, "response_phrases");

        String query = String.format("SELECT * FROM response_phrases WHERE content LIKE '%s'", _content);
        if(this.db.getResultCount(query) > 0){
            this.db.query(query);
            this.db.next();
        }else{
            this.db.query("INSERT INTO response_phrases (content) VALUES ('%s')", _content);
            this.db.query("SELECT * FROM response_phrases ORDER BY id DESC LIMIT 1");
            this.db.next();
        }
        this.id = this.db.getInt("id");
        this.meaningID = this.db.getInt("meaning_id");
        this.content = this.db.getString("content");

    }

    public boolean meansYes(){
        return this.meaningID == ResponsePhrase.MEANING_YES;
    }

    public boolean meansNo(){
        return this.meaningID == ResponsePhrase.MEANING_NO;
    }

    public void setMeaningYes(){
        this.meaningID = ResponsePhrase.MEANING_YES;
        this.db.query("UPDATE response_phrases SET meaning_id = %s WHERE id = %s", this.meaningID, this.id);
    }

    public void setMeaningNo(){
        this.meaningID = ResponsePhrase.MEANING_NO;
        this.db.query("UPDATE response_phrases SET meaning_id = %s WHERE id = %s", this.meaningID, this.id);
    }
}
