

class ChildBot extends TextToSpeech{
    String host;
    String database;
    String table;
    String user;
    String pass;
    PApplet applet;
    MySQL db;
    boolean connectionEstablished;

    String query;

    int currentPhraseID;

    ChildBot(PApplet _applet, String _voice, String _conversationTable){
        super(_voice);

        this.applet = _applet;

    }

    void speak(String _text, boolean _continous){
        this.say(_text);
        if(!_continous){
            // this.justFinished = true;
        }
    }

    boolean nextPhrase(){
        println("nextPhrase");
        if(this.connectionEstablished && this.query.length() != 0){
            if(this.db.next()){
                boolean addNextPhrase = this.db.getString("expected_response").length() == 0;
                this.currentPhraseID = this.db.getInt("phrase_id");
                this.speak(this.db.getString("q"), addNextPhrase);
                if(addNextPhrase){
                    this.nextPhrase();
                }
                return true;
            }
        }
        return false;
    }


}
