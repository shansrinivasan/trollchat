package trollchat

class TCUser {
	String tcHandle
	Date createDate
	String emailAddress
	
	static hasMany = [messages:Message]
	
	
	static constraints = {
    }
}
