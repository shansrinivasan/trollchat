package trollchat

import grails.transaction.Transactional

@Transactional
class TrollChatService {

	def loginUser(String tcHandle,String email,String url) {
		TrollChatItem trollChatItem = TrollChatItem.findByUrl(url)
		if(!trollChatItem){
			trollChatItem = new TrollChatItem(url:url,createdDate:new Date())
		}
		User user = User.findByTcHandle(tcHandle)
		if(!user){
			user = new User(tcHandle:tcHandle,email:email).save()
		}
		trollChatItem.activeUsers << user
		trollChatItem.save()
	}
}