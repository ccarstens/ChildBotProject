class DBConnection extends MySQL{

    public String server = "localhost";
    public String database = "childbot";
    public String user = "root";
    public String pass = "root";
    public String conversationTable;

    public bool connectionEstablished = false;

    public DBConnection(PApplet _papplet){
        super(_papplet, server, database, user, pass);
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
        this.conversationTable = _table;
        this.runQuery("SELECT * FROM " + this.table + " LEFT JOIN general_questions ON phrase_id = general_questions.id");
    }
}
