package trollchat

import grails.transaction.Transactional

@Transactional
class TrollChatService {
	def getAllMessagesForURL(String url){
		TCItem tcItem = TCItem.findByUrl(url)
		tcItem.messages.sort{it.date}
	}
	def getTrendingVideos(){
		def messages = Message.findAll();
		messages.sort{it.date}
		messages*.tcItem
	}
	def loginUser(String tcHandle,String email,String url) {
		
		TCItem tcItem = TCItem.findByUrl(url)
		if(!tcItem){
			tcItem = new TCItem(url:url,createdDate:new Date())
			
		}
		TCUser user = TCUser.findByTcHandle(tcHandle)
		if(!user){
			user = new TCUser(tcHandle:tcHandle,emailAddress:email,createDate :new Date())
		}
		Message msg = new Message(message:tcHandle+' Logged on')
		msg.user = user
		msg.tcItem = tcItem
		tcItem.addToActiveUsers(user)
		tcItem.save(flush:true)
		['user':user,'tcItem':tcItem]
	}
}