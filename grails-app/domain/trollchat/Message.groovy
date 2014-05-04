package trollchat

class Message {
	
	Date date = new Date()
	String message
	
	static hasOne = [user:TCUser,tcItem:TCItem]
	
	static constraints = {
    }
}
