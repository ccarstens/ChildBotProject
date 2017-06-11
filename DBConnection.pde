class DBConnection extends MySQL{

    public PApplet applet;
    public String conversationTable;

    public boolean connectionEstablished = false;

    public DBConnection(PApplet _applet, String _conversationTable){
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
}
