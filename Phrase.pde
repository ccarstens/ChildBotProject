class Phrase {
  
  
  int id;
  int catID;
  boolean isBase;
  String content;
  String expectedResponseType;
  boolean isExit;
  int nextPhraseTrue;
  int nextPhraseFalse;
  DBConnection db;
  
  
  Phrase(int _id, DBConnection _db ){
    
    this.id = _id;
    this.db = _db;
  
    if (this.db.connectionEstablished == true){
      println("Hallo");
    }
  
    this.db.query ("SELECT * FROM general_phrases WHERE id = " + this.id);
    println(this.db.previousQuery);
    
    this.db.next();
    this.content = this.db.getString("content");
    println(this.content);
    
    this.catID = this.db.getInt("cat_id");
    this.isBase = this.db.getBoolean("is_base");
    this.expectedResponseType = this.db.getString("expected_response_type");
    this.isExit = this.db.getBoolean("is_exit_point");
    this.nextPhraseTrue = this.db.getInt("follow_up_phrase_if_true");
    this.nextPhraseFalse = this.db.getInt("follow_up_phrase_if_false");
    
 
    
    
      
    
      
    
    
    }
  
 
  }
  
  
  
  