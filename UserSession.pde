class UserSession{
    public Date startDateTime;
    public int id;
    public String userName;

    public DBConnection db;

    protected boolean sessionOpen = true;

    public UserSession(DBConnection _db){
        this.startDateTime = new Date();
        this.db = _db;
        this.id = this.db.getNewUserSessionID();
    }

    public void close(){
        if(this.sessionOpen){
            this.db.query("UPDATE user_sessions SET user_name = '%s' WHERE id = %s", this.userName, this.id);
            this.sessionOpen = false;
        }

    }
}
