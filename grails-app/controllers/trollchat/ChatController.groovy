package trollchat

import grails.converters.JSON

class ChatController {
	
	def trollChatService
	
	def index() {
	}
	
	def retrieveLatestMessages() {
		def result = session.result
		TCItem item  = result?.tcItem
		
		def messages = trollChatService.getAllMessagesForURL(item?.url)
		['messages':messages]
	}
	
	def retrieveMessagesForUrl() {
		
		def inUrl = params.inUrl;
		
		def messages = trollChatService.getAllMessagesForURL(inUrl)
		[messages:messages]
		
		println messages
		render messages as JSON
	}
	
	def retrieveTrendingVideos() {
		def result = session.result
		TCItem item  = result?.tcItem
		def videos = trollChatService.getTrendingVideos(item.url)
		['trendingVideos':videos]
	}

	def submitMessage(String message) {
		new Message(user: session.result.user,tcItem:session.result.tcItem, message:message).save()
		render "<script>retrieveLatestMessages()</script>"
	}

	def join(String tcHandle,String email,String url) {
		if(url && url.indexOf('youtube')!=-1 && url.indexOf('v=')){
			url = url.substring(url.indexOf('v=')+2)
		}
		if(!tcHandle){
			tcHandle = session.result?.user?.tcHandle
		}
		if(!email){
			email = session.result?.user?.emailAddress
		}
		if (!tcHandle || tcHandle.trim() == '' ) {
			redirect(action:'index')//8770065
		} else {
			def result = trollChatService.loginUser(tcHandle, email, url)
			session.result = result
			render (view: 'chat')
		}
	}
}
