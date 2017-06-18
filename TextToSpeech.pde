class TextToSpeech {
    String voice;
    boolean speechInProgress;
    
    TextToSpeech(String voice){
      this.voice = voice;
      this.speechInProgress = false;
    }

    String getVoice(){
      return this.voice;
    }

    void say(String text){
        try{
            this.speechInProgress = true;
            Runtime r = Runtime.getRuntime();
            Process p = r.exec("say -v  " + this.voice + " " + text);
            p.waitFor();
            this.speechInProgress = false;
        }catch(IOException e){
            println("IOException");
        }catch(InterruptedException e){
            println("InterruptedException");
        }
    }
}