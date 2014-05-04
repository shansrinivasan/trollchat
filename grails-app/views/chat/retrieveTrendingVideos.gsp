<g:each in="${trendingVideos}" var="trendingVideo">
    <tr>
      <td><g:video videoKey="${trendingVideo.url}" width="140px" height="100px" /></td>
    </tr>
</g:each>