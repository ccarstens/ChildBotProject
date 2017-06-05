import de.bezier.data.sql.*;

class ChildBot extends TextToSpeech{
    String host;
    String database;
    String table;
    String user;
    String pass;
    PApplet applet;
    MySQL db;
    boolean connectionEstablished;
    int currentLineId;

    String query;

    boolean justFinished;


    ChildBot(PApplet _applet, String _voice, String _host, String _database, String _table, String _user, String _pass){
        super(_voice);

        this.applet = _applet;

        this.host = _host;
        this.database = _database;
        this.user = _user;
        this.pass = _pass;

        this.connectionEstablished = false;
        this.currentLineId = 1;
        this.connect();
        this.switchTable(_table);
    }

    void connect(){
        this.db = new MySQL(this.applet, this.host, this.database, this.user, this.pass);
        if(this.db.connect()){
            this.connectionEstablished = true;
        }
    }

    void runQuery(String _query){
        if(this.connectionEstablished){
            this.query = _query;
            this.db.query(this.query);
        }
    }

    void speak(String _text, boolean _continous){
        this.say(_text);
        if(!_continous){
            this.justFinished = true;
        }
    }

    void nextPhrase(){
        if(this.connectionEstablished && this.query.length() != 0){
            if(this.db.next()){
                boolean addNextPhrase = this.db.getString("expected_answer").length() == 0;
                this.speak(this.db.getString("q"), addNextPhrase);
                if(addNextPhrase){
                    this.nextPhrase();
                }
            }
        }
    }

    void switchTable(String _table){
        this.table = _table;
        this.runQuery("SELECT * FROM " + this.table);
    }

}
