package trollchat



import grails.test.mixin.TestFor;
import spock.lang.*

/**
 *
 */
@TestFor(TrollChatService)
class TrollChatServiceIntegrationSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test login user"() {
		when:
			service.loginUser("testHandle", "test@email.com", "https://www.youtube.com/watch?v=J---aiyznGQ")
		then:
			TCUser.findByTcHandle("testHandle")
			TCItem.findByUrl("https://www.youtube.com/watch?v=J---aiyznGQ")
		
    }

}
