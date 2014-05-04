<tr>
	<g:each in="${trendingVideos}" var="trendingVideo">
		<td><g:video videoKey="${trendingVideo.url}" width="140px"
				height="100px" /></td>
	</g:each>
</tr>