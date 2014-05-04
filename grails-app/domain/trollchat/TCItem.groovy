package trollchat

class TCItem {
	Date createdDate
	String url
	
	static hasMany = [activeUsers:TCUser,messages:Message]
	static belongsTo = TCUser
    static constraints = {
    }
}
