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

    public int getBooleanResponseID(String _response){
        String query = String.format("SELECT * FROM %s WHERE content LIKE '%s'", "boolean_response_labels", _response);
        if(this.getResultCount(query) > 0){
            this.query(query);
            this.next();
            return this.getInt("id");
        }else{
            returnn -1;
        }

    }

    public int getResultCount(String _query){
        this.query(_query.replaceAll("SELECT.*FROM", "SELECT COUNT(*) FROM"));
        this.next();
        return this.getInt(1);
    }
}
