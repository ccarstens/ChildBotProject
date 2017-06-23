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

    public void say(String text, int duration, int offset){
        try{
            this.speechInProgress = true;
            Runtime r = Runtime.getRuntime();
            delay(offset);
            Process p = r.exec("say -v  " + this.voice + " " + text);
            p.waitFor(duration - offset, TimeUnit.MILLISECONDS);
            this.speechInProgress = false;
        }catch(IOException e){
            println("IOException");
        }catch(InterruptedException e){
            println("InterruptedException");
        }
    }

    public void sayWaitFor(String text){
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
