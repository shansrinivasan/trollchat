<html>
<head>
	<link href="/TrollChat/css/application.css" rel="stylesheet" type="text/css">
	<title></title>
			<g:javascript library="application"/>		
	 <g:javascript library="jquery"/>
		<r:layoutResources />
	
	<script>
    function messageKeyPress(field,event) {
        var theCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
        var message = $('#messageBox').val();
        if (theCode == 13){
            <g:remoteFunction action="submitMessage" params="\'message=\'+message" update="temp"/>
            $('#messageBox').val('');
            return false;
        } else {
            return true;
        }
    }
    function retrieveLatestMessages() {
        <g:remoteFunction action="retrieveLatestMessages" update="chatMessages"/>
    }
    function retrieveTrendingVideos() {
        <g:remoteFunction action="retrieveTrendingVideos" update="trendingVideos"/>
    }
    function pollMessages() {
        retrieveLatestMessages();
        setTimeout('pollMessages()', 5000);
    }
    pollMessages();
    function pollVideos() {
        retrieveTrendingVideos();
        setTimeout('pollVideos()', 10000);
    }
    pollVideos();
</script>
</head>
<body>
	<div class="navbar navbar-default">
	  <div class="navbar-header">
	    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
	      <span class="icon-bar"></span>
	      <span class="icon-bar"></span>
	      <span class="icon-bar"></span>
	    </button>
	    <a class="navbar-brand" href="#">ChatDash</a>
	  </div>
	  <div class="navbar-collapse collapse navbar-responsive-collapse">
	    <ul class="nav navbar-nav navbar-right">
	      <li><a href="#">Logout</a></li>
	    </ul>
	  </div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-7">
				<div class="form-group">
				  <div class="input-group">
				    <span class="input-group-addon">url</span>
				    <input type="text"  name="tcUrl" class="form-control">
				    <span class="input-group-btn">
				      <button class="btn btn-default" type="button">Dash</button>
				    </span>
				  </div>
				</div>
<g:video videoKey="${session.result.tcItem.url}" width="640px" height="390px" /><%--
				    <div class="gwd-div-ftpg" id="ytplayer"></div>

				<script>
				  // Load the IFrame Player API code asynchronously.
				  var tag = document.createElement('script');
				  tag.src = "https://www.youtube.com/player_api";
				  var firstScriptTag = document.getElementsByTagName('script')[0];
				  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

				  // Replace the 'ytplayer' element with an <iframe> and
				  // YouTube player after the API code downloads.
				  var player;
				  function onYouTubePlayerAPIReady() {
				    player = new YT.Player('ytplayer', {
				      height: '390',
				      width: '640',
				      videoId: '${session.result.tcItem.url}'
				    });
				  }
					</script>
				--%></div>
			<div class="col-md-3">
				<table class="table table-striped table-hover ">
				  <thead>
				    <tr>
				      <th class="accent">TRENDING</th>
				    </tr>
				  </thead>
				  <tbody>
		<div  id="trendingVideos">
		</div>
				  </tbody>
				</table>
			</div>
			<div class="col-md-1"></div>

		</div>
<!-- 		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-7">
				<h2>Title of Video</h2>
			</div>
			<div class="col-md-4"></div>
		</div> -->
		<div  id="chatMessages">
		</div>
		<div id="temp"></div>
		<div class="row">
<input type="text" id="messageBox" name="message" onkeypress="messageKeyPress(this,event);"/>
</div>
	</div>





</body>
</html>

