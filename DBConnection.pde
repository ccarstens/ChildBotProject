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

    public int[] getBooleanResponseData(String _response){
        String query = String.format("SELECT * FROM %s WHERE content LIKE '%s'", "boolean_response_labels", _response);
        int[] returnValues;
        if(this.getResultCount(query) > 0){
            this.query(query);
            this.next();
            return new int[]{this.getInt("id"), this.getInt("meaning_id")};
        }else{
            return new int[]{-1};
        }
    }

    public int getResultCount(String _query){
        this.query(_query.replaceAll("SELECT.*FROM", "SELECT COUNT(*) FROM"));
        this.next();
        return this.getInt(1);
    }

    public void logResponseWithID(int _phrase_id, int _response_id){
        println("LOG START");
        String query = String.format("INSERT INTO responses (session_id, phrase_id, response_id) VALUES (%s, %s, %s)", 99, _phrase_id, _response_id);
        this.query(query);
        println("LOG END");
    }

    public void logResponseWithMessage(int _phrase_id, String _message){
        this.query("INSERT INTO responses (session_id, phrase_id, variable_response_content) VALUES (%s, %s, '%s')", 60, _phrase_id, _message);
    }
}
