class UserSession{
    public Date startDateTime;
    public int id;

    public DBConnection db;

    protected boolean sessionOpen = true;

    public UserSession(DBConnection _db){
        this.startDateTime = new Date();
        this.db = _db;
        this.id = this.db.getNewUserSessionID();
    }

    public void close(){
        if(this.sessionOpen){
            println("closing session " + this.id);
            this.db.closeUserSessionByID(this.id);
            this.sessionOpen = false;
        }

    }
}
