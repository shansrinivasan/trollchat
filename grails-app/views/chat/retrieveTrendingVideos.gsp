<tr>
	<g:each in="${trendingVideos}" var="trendingVideo">
		<td onmouseover="$('#${trendingVideo.url}').show()" onmouseout="$('#${trendingVideo.url}').hide()">
		<div id="${trendingVideo.url}" style="display:none">
			<g:link controller="chat" action="join"
				params="[url:trendingVideo.url]" >
					Dash On this now!!
			</g:link>
		</div>
				<g:video videoKey="${trendingVideo.url}" width="140px"
					height="100px" />
				
			</td>
	</g:each>
</tr>