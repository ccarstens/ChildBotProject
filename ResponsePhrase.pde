class ResponsePhrase extends Phrase{

    int meaningID;

    ResponsePhrase(int _id, DBConnection _db){
        super(_id, _db, "response_phrases");

        this.meaningID = this.db.getInt("meaning_id");
    }

    ResponsePhrase(String _content, DBConnection _db){
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
        this.meaningID = this.db.getInt("id");
        this.content = this.db.getString("content");

    }
}
