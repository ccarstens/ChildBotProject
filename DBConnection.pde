class DBConnection extends MySQL{

    public PApplet applet;
    public String conversationTable;

    public boolean connectionEstablished = false;

    public static final int MEANING_YES = 100;
    public static final int MEANING_NO = 101;

    public DBConnection(PApplet _applet){
        super(_applet, "localhost:8889", "childbot", "root", "root");
        this.applet = _applet;

        if(this.connect()){
            this.connectionEstablished = true;
        }
    }

    public void runQuery(String _query){
        if(this.connectionEstablished){
            this.query(_query);
        }
    }

    public void switchToConversationTable(String _table){
        if(this.connectionEstablished){
            this.conversationTable = _table;
            this.runQuery("SELECT * FROM " + this.conversationTable + " LEFT JOIN general_questions ON phrase_id = general_questions.id");
        }

    }

    public int[] getResponsePhraseData(String _response){
        String query = String.format("SELECT * FROM response_phrases WHERE content LIKE '%s'", _response);
        int[] returnValues;
        if(this.getResultCount(query) > 0){
            this.query(query);
            this.next();

        }else{
            println("Start updating response_phrase table");
            this.query("INSERT INTO response_phrases (content) VALUES ('%s')", _response);
            println("END updating");
            println("Start Select");
            this.query("SELECT * FROM response_phrases ORDER BY id DESC LIMIT 1");
            this.next();
            println("END SELECT");
        }
        return new int[]{this.getInt("id"), this.getInt("meaning_id")};
    }

    public int getResultCount(String _query){
        this.query(_query.replaceAll("SELECT.*FROM", "SELECT COUNT(*) FROM"));
        this.next();
        return this.getInt(1);
    }

    public void logResponseWithID(int _sessionID, int _phrase_id, int _response_id){
        this.query("INSERT INTO responses (session_id, phrase_id, response_phrase_id) VALUES (%s, %s, %s)", _sessionID, _phrase_id, _response_id);
    }



    public int getNewUserSessionID(){
        //trigger the CURRENT_TIMESTAMP default value for start_datetime by inserting zero in finish_datetime
        this.query("INSERT INTO user_sessions (finish_datetime) VALUES (0)");
        this.query("SELECT * FROM user_sessions ORDER BY id DESC LIMIT 1");
        this.next();
        return this.getInt("id");
    }

    public void closeUserSessionByID(int _sessionID){
        this.query("UPDATE user_sessions SET u = 1 WHERE id = %s", _sessionID);
    }

}
