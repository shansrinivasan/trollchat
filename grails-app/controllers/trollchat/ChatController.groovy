package trollchat

class ChatController {
	
	def trollChatService
	
	def index() {
	}
	
	def retrieveLatestMessages() {
		def result = session.result
		TCItem item  = result?.tcItem
		
		def messages = trollChatService.getAllMessagesForURL(item.url)
		[messages:messages]
	}
	
	def submitMessage(String message) {
		new Message(user: session.result.user,tcItem:session.result.tcItem, message:message).save()
		render "<script>retrieveLatestMessages()</script>"
	}

	def join(String nickname) {
		if (!nickname || nickname.trim() == '' ) {
			redirect(action:'index')
		} else {
			def result = trollChatService.loginUser(nickname, "nickname@email.com", "SuperURL")
			session.result = result
			render (view: 'chat')
		}
	}
}
