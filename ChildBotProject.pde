Conversation c = new Conversation(this, "Lea",  "localhost:8889", "childbot", "zwischenpraesenation", "root", "root", 7777, "/childbo");

void setup(){

    c.bot.nextPhrase();

}
void draw(){
    c.communicate();
}

void webSocketServerEvent(String _message){
    println(_message);
    c.bot.nextPhrase();
}
