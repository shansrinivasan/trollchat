<html>
<head>
	<link href="<g:resource dir="css" file="application.css"/>" rel="stylesheet" type="text/css">
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
	  	<g:img dir="images" file="chatdashLogo.png"/>
	    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
	      <span class="icon-bar"></span>
	      <span class="icon-bar"></span>
	      <span class="icon-bar"></span>
	    </button>
	  </div>
	  <div class="navbar-collapse collapse navbar-responsive-collapse">
	    <ul class="nav navbar-nav navbar-right">
	      <li><a href="#">Logout</a></li>
	    </ul>
	  </div>
	</div>
	<div class="container">
		<div class="row">
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
			<g:video videoKey="${session.result.tcItem.url}" width="650px" height="390px" /></div>
			<div class="col-md-5">
				<div class="chat-box">
					<div  id="chatMessages"></div>
						<div id="temp"></div>
				</div>
				
					<input type="text" class="form-control" id="messageBox" name="message" onkeypress="messageKeyPress(this,event);"/>
				
			</div>
		</div>

				
				
				
				

		
			<div class="row">
				<div class="col-md-12"	>
					<table class="table">
					  <thead>
					    <tr>
					      <th class="accent">TRENDING</th>
					    </tr>
					  </thead>
					  <tbody>			  
						<div  id="trendingVideos">
					  </tbody>
					</table>
				</div>
			
			</div>
		</div>






</body>
</html>

