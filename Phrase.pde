class Phrase extends TextToSpeech{


    int id;
    String content;
    DBConnection db;


    Phrase(int _id, DBConnection _db, String _tableName){
        super("Lea");
        this.id = _id;
        this.db = _db;

        this.db.query ("SELECT * FROM " + _tableName +  " WHERE id = " + this.id);
        this.db.next();
        this.content = this.db.getString("content");











    }


}
