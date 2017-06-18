class Phrase extends TextToSpeech{


  int id;
  String content;
  DBConnection db;


  Phrase(int _id, DBConnection _db, String _tableName){

    this.id = _id;
    this.db = _db;

    if (this.db.connectionEstablished == true){
      println("Hallo");
    }

    this.db.query ("SELECT * FROM " + _tableName +  " WHERE id = " + this.id);
    println(this.db.previousQuery);

    this.db.next();
    this.content = this.db.getString("content");











    }


  }
