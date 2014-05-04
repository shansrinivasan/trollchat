<g:each in="${messages}" var="message">
		<div id="chatMessages">
			<div class="col-md-1"></div>
			<div class="col-md-7">
				<div class="well well-lg chat-box">
					<div class="row">
						<div class="col-md-2 chat-user-name">
		  				<p>${message.user.tcHandle}</p> 
		  			</div>
		  			<div class="col-md-7 chat-text">
		  				<p>${message.message} </p>
						</div>
						<div class="col-md-2 chat-stamp">
							<p><g:formatDate date="${message.date}" type="time" style="SHORT"/></p>
						</div>
					</div>
				</div>
			</div>
		</div>
</g:each>