package trollchat

import grails.transaction.Transactional

@Transactional
class TrollChatService {
	def getAllMessagesForURL(String url){
		TCItem tcItem = TCItem.findByUrl(url)
		return tcItem.messages.sort{it.date}
	}
	def loginUser(String tcHandle,String email,String url) {
		
		TCItem tcItem = TCItem.findByUrl(url)
		if(!tcItem){
			tcItem = new TCItem(url:url,createdDate:new Date())
			
		}
		TCUser user = TCUser.findByTcHandle(tcHandle)
		if(!user){
			user = new TCUser(tcHandle:tcHandle,emailAddress:email,createDate :new Date())
//			user.save(flush:true)
		}
		Message msg = new Message(message:tcHandle+' Logged on')
		msg.user = user
		msg.tcItem = tcItem
//		user.addToCommentedItems(tcItem)
		tcItem.addToActiveUsers(user)
		
		tcItem.save(flush:true)
		['user':user,'tcItem':tcItem]
	}
}