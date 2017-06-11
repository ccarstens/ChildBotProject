Conversation c = new Conversation(this, "Lea",  "localhost:8889", "childbot", "zwischenpraesenation", "root", "root", 7777, "/childbo");

void setup(){
    c.communicate();

}
void draw(){

}

void webSocketServerEvent(String _message){
    c.onWebSocketMessage(_message);
}
