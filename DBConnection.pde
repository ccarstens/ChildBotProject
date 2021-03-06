class DBConnection extends MySQL{

    public PApplet applet;
    public String conversationTable;

    public boolean connectionEstablished = false;

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

    public int getResultCount(String _query){
        this.query(_query.replaceAll("SELECT.*FROM", "SELECT COUNT(*) FROM"));
        this.next();
        return this.getInt(1);
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
