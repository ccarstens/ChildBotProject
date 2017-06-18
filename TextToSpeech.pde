class TextToSpeech {
    public String voice;
    public boolean speechInProgress;

    public TextToSpeech(String voice){
      this.voice = voice;
      this.speechInProgress = false;
    }

    public String getVoice(){
      return this.voice;
    }

    public void say(String text){
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
